import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:find_duplicate/services/file_management.dart';

Future<void> findDuplicateIsolated(InputModel inputModel) async {
  inputModel.sendPort.send(OutputModel(isRunning: true));
  Map<String, List<String>> hashMap = {};
  int itemCount = 0;

  for (String fileItem in inputModel.pathItems) {
    try {
      // Opening file
      final file = File(fileItem);
      final int totalFileSize = await file.length();
      int readFileSize = 0;
      // Sending current status to the main
      inputModel.sendPort.send(OutputModel(currentFile: fileItem, totalFileSize: totalFileSize, readFileSize: readFileSize, itemCount: itemCount));

      final inputStream = file.openRead();
      final List<int> chunkElement = [];
      await inputStream.forEach((element) {
        chunkElement.addAll(sha256.convert(chunkElement).bytes);
        readFileSize = readFileSize + element.length;
        // Sending current status to the main
        inputModel.sendPort.send(OutputModel(readFileSize: readFileSize));
      });

      final digest = sha256.convert(chunkElement).toString();

      if (hashMap[digest] == null) {
        hashMap[digest] = [fileItem];
      } else {
        hashMap[digest]!.add(fileItem);
      }

      inputModel.sendPort.send(OutputModel(hashMap: hashMap));
    } catch (e) {
      print(e);
    }
    itemCount = itemCount + 1;
  }
  inputModel.sendPort.send(OutputModel(isRunning: false, itemCount: itemCount));
}

Future<String> calculateSha256(String filePath) async {
  final file = File(filePath);
  int fileSize = await file.length();
  print(fileSize);
  final input = file.openRead();

  await input.forEach((chunk) {
    print("${chunk.length}  ${sha256.convert(chunk).bytes.length}");
  });

  return "hash.toString()";
}
