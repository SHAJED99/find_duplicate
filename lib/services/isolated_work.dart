import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:find_duplicate/services/file_management.dart';

Future<void> findDuplicateIsolated(InputModel inputModel) async {
  inputModel.sendPort.send(OutputModel(isRunning: true, duplicateFiles: {}));
  Map<String, List<String>> hashMap = {};
  Map<String, List<String>> duplicateFiles = {};
  int itemCount = 0;

  for (String fileItem in inputModel.pathItems) {
    try {
      // Opening file
      final file = File(fileItem);
      final int totalFileSize = await file.length();
      int readFileSize = 0;
      // Sending current status to the main
      inputModel.sendPort.send(OutputModel(currentFile: fileItem, totalFileSize: totalFileSize, readFileSize: readFileSize, itemCount: itemCount));

      String sha256Hash = "";

      // Opening file steam
      var inputSteam = file.openRead();

      await inputSteam.forEach((element) {
        sha256Hash = sha256Hash + sha256.convert(element).toString();
        sha256Hash = sha256.convert(utf8.encode(sha256Hash)).toString();
        readFileSize = readFileSize + element.length;
        inputModel.sendPort.send(OutputModel(readFileSize: readFileSize));
      });
      print(sha256Hash.length);

      final digest = sha256.convert(utf8.encode(sha256Hash)).toString();

      print("$totalFileSize $fileItem $digest");

      if (hashMap[digest] == null) {
        hashMap[digest] = [fileItem];
      } else {
        hashMap[digest]!.add(fileItem);
        duplicateFiles[digest] = hashMap[digest]!;
      }

      inputModel.sendPort.send(OutputModel(duplicateFiles: duplicateFiles));
    } catch (e) {
      print(e);
    }
    itemCount = itemCount + 1;
  }
  inputModel.sendPort.send(OutputModel(isRunning: false, itemCount: itemCount));
}
