import 'dart:io';
import 'package:find_duplicate/services/isolated_work.dart';
import 'package:get/get.dart';
import 'dart:isolate';
import 'package:tuple/tuple.dart';

class FileManagement extends GetxController {
  String? path;
  List<String> pathList = [];
  List<String> pathItems = [];

  // Status variables
  Map<String, List<String>> hashMap = {};
  String? currentFile;
  bool isRunning = false;
  int itemCount = 0;
  int totalFileSize = 0;
  int readFileSize = 0;
  // Creating Isolated Service
  ReceivePort _receivePort = ReceivePort();

  // Getting all files in those path
  Future<void> findDuplicate() async {
    hashMap = {};
    _receivePort = ReceivePort();
    if (path == null) return;
    // Get All folders and subfolder and Items
    final temp = await traverseDirectory(directory: Directory(path ?? ""));
    pathList = temp.item1;
    pathItems = temp.item2;

    await Isolate.spawn<InputModel>(findDuplicateIsolated, InputModel(sendPort: _receivePort.sendPort, pathItems: pathItems));

    // Update current status of the isolate thread
    _receivePort.listen(<OutputModel>(outputModel) {
      hashMap = outputModel.hashMap ?? hashMap;
      currentFile = outputModel.currentFile ?? currentFile;
      isRunning = outputModel.isRunning ?? isRunning;
      itemCount = outputModel.itemCount ?? itemCount;
      totalFileSize = outputModel.totalFileSize ?? totalFileSize;
      readFileSize = outputModel.readFileSize ?? readFileSize;
      update();
    });
  }

  void initVariables() {
    try {
      _receivePort.close();
      path = null;
      pathList = [];
      pathItems = [];
      currentFile = null;
      isRunning = false;
      itemCount = 0;
      totalFileSize = 0;
      readFileSize = 0;
      update();
    } catch (e) {
      print(e);
    }
  }
}

class InputModel {
  final SendPort sendPort;
  final List<String> pathItems;

  InputModel({required this.sendPort, required this.pathItems});
}

class OutputModel {
  final Map<String, List<String>>? hashMap;
  String? currentFile;
  final bool? isRunning;
  final int? itemCount;
  final int? totalFileSize;
  final int? readFileSize;

  OutputModel({this.hashMap, this.isRunning, this.itemCount, this.currentFile, this.totalFileSize, this.readFileSize});
}

// Get All folders and subfolder and Items
Future<Tuple2<List<String>, List<String>>> traverseDirectory({required Directory directory}) async {
  List<String> pathList = [];
  List<String> pathItems = [];

  try {
    List<FileSystemEntity> entities = directory.listSync();
    for (FileSystemEntity entity in entities) {
      if (entity is Directory) {
        pathList.add(entity.path);
        final temp = await traverseDirectory(directory: entity);
        pathList.addAll(temp.item1);
        pathItems.addAll(temp.item2);
      } else {
        pathItems.add(entity.path);
      }
    }
  } catch (_) {}

  return Tuple2(pathList, pathItems);
}
