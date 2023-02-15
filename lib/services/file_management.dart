import 'dart:io';
import 'package:find_duplicate/services/isolated_work.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'dart:isolate';
import 'package:easy_folder_picker/DirectoryList.dart';
import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:tuple/tuple.dart';

class FileManagement extends GetxController {
  String path = "D:/New Folder";
  List<String> pathList = [];
  List<String> pathItems = [];
  OutputModel currentStatus = OutputModel();

  // Getting all files in those path
  Future<void> findDuplicate() async {
    // Get All fulders and subfolders and Items
    final temp = await traverseDirectory(directory: Directory(path));
    pathList = temp.item1;
    pathItems = temp.item2;

    // Creating Isolated Service
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn<InputModel>(findDuplicateIsolated, InputModel(sendPort: receivePort.sendPort, pathItems: pathItems));

    receivePort.listen(<OutputModel>(outputModel) {
      currentStatus = outputModel;
    });

    receivePort.close();
  }
}

class InputModel {
  final SendPort sendPort;
  final List<String> pathItems;

  InputModel({required this.sendPort, required this.pathItems});
}

class OutputModel {
  final Map<String, List<String>> hashMap;
  String? currentFile;
  final bool isRunning;
  final int itemCount;

  OutputModel({this.hashMap = const {}, this.isRunning = false, this.itemCount = 0, this.currentFile});
}

// Get All fulders and subfolders and Items
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
