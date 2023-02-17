import 'dart:io';
import 'package:find_duplicate/services/isolated_work.dart';
import 'package:get/get.dart';
import 'dart:isolate';
import 'package:tuple/tuple.dart';

class FileManagement extends GetxController {
  String? path;
  late List<String> pathList;
  late List<String> pathItems;

  // Status variables
  late Map<String, List<String>> duplicateFiles;
  String? currentFile;
  late bool isRunning;
  late int itemCount;
  late int totalFileSize;
  late int readFileSize;
  late List<String> ignoreFiles = [];
  // Creating Isolated Service
  ReceivePort _receivePort = ReceivePort();

  FileManagement() {
    initVariables();
  }

  // Getting all files in those path
  Future<void> findDuplicate() async {
    _receivePort = ReceivePort();
    if (path == null) return;
    // Get All folders and subfolder and Items
    final temp = await traverseDirectory(directory: Directory(path ?? ""));
    pathList = temp.item1;
    pathItems = temp.item2;

    await Isolate.spawn<InputModel>(findDuplicateIsolated, InputModel(sendPort: _receivePort.sendPort, pathItems: pathItems));

    // Update current status of the isolate thread
    _receivePort.listen(<OutputModel>(outputModel) {
      duplicateFiles = outputModel.duplicateFiles ?? duplicateFiles;
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
      // _receivePort;
      path = null;
      pathList = [];
      pathItems = [];

      duplicateFiles = {};
      currentFile = null;
      isRunning = false;
      itemCount = 0;
      totalFileSize = 0;
      readFileSize = 0;
      ignoreFiles = [];
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
  final Map<String, List<String>>? duplicateFiles;
  String? currentFile;
  final bool? isRunning;
  final int? itemCount;
  final int? totalFileSize;
  final int? readFileSize;
  final List<String>? ignoreFiles;

  OutputModel({this.ignoreFiles, this.duplicateFiles, this.isRunning, this.itemCount, this.currentFile, this.totalFileSize, this.readFileSize});
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
