import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/styles.dart';
import 'package:find_duplicate/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSystemPath extends StatelessWidget {
  SelectSystemPath({super.key});

  final FileManagement fileManagement = Get.find();

  Future<void> _pickDirectory(BuildContext context) async {
    fileManagement.path = await FilePicker.platform.getDirectoryPath();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileManagement>(builder: (_) {
      return CustomElevatedButton(
        colorValue: fileManagement.pathItems.isEmpty ? 1 : fileManagement.itemCount / fileManagement.pathItems.length,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(
          left: defaultPadding / 2,
          right: defaultPadding / 2,
          top: defaultPadding / 2,
          bottom: defaultPadding / 4,
        ),
        onTap: () async {
          if (fileManagement.isRunning) return;
          await _pickDirectory(context);
          if (fileManagement.path != null) await fileManagement.findDuplicate();
        },
        child: Text(fileManagement.path == null ? "Select Path" : "Scanning", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: defaultPadding, color: Colors.white)),
      );
    });
  }
}
