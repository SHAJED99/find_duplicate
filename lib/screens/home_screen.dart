import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/styles.dart';
import 'package:find_duplicate/widgets/buttons.dart';
import 'package:find_duplicate/widgets/current_item.dart';
import 'package:find_duplicate/widgets/show_file_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FileManagement fileManagement = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Duplicate Files"),
      ),
      body: Column(
        children: [
          CurrentItem(),
          ShowFileList(),
          const Spacer(),
          GetBuilder<FileManagement>(builder: (context) {
            return CustomElevatedButton(
              colorValue: fileManagement.pathItems.isEmpty ? 1 : fileManagement.itemCount / fileManagement.pathItems.length,
              margin: const EdgeInsets.only(
                left: defaultPadding / 2,
                right: defaultPadding / 2,
                top: defaultPadding / 2,
                bottom: defaultPadding / 4,
              ),
              onTap: () async {
                if (fileManagement.isRunning) return;
                await fileManagement.findDuplicate();
              },
              child: const Text("Go", style: TextStyle(fontWeight: FontWeight.bold, fontSize: defaultPadding, color: Colors.white)),
            );
          }),
        ],
      ),
    );
  }
}
