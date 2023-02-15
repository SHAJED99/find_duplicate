import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/widgets/getting_file_path.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fileManagement.initVariables();
        },
      ),
      body: Column(
        children: [
          CurrentItem(),
          ShowFileList(),
          const Spacer(),
          SelectSystemPath(),
        ],
      ),
    );
  }
}
