import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:find_duplicate/services/file_management.dart';

Future<void> findDuplicateIsolated(InputModel inputModel) async {
  Map<String, List<String>> hashMap = {};
  int itemCount = 0;

  for (String fileItem in inputModel.pathItems) {
    // print(fileItem);
    inputModel.sendPort.send(OutputModel(
      isRunning: true,
      currentFile: fileItem,
      hashMap: hashMap,
      itemCount: itemCount,
    ));

    try {
      // Open file stream
      final file = File(fileItem);
      final inputStream = file.openRead();
      final List<List<int>> list = await inputStream.toList();

      String digest = "";

      // print(list.length);
      final List<int> content = list.expand((i) {
        print(i.length);
        digest = digest + i.toString();
        return i;
      }).toList();
      print(content.length);
      print(digest.length);

      // Converting Unique ID
      // final digest = sha256.convert(content).toString();

      // Checking if item is unique
      //   if (hashMap[digest] == null) {
      //     hashMap[digest] = [fileItem];
      //   } else {
      //     hashMap[digest]!.add(fileItem);
      //   }
    } catch (e) {
      print(e);
    }
  }
  print("Done");
}
