import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/styles.dart';
import 'package:find_duplicate/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowFileList extends StatelessWidget {
  ShowFileList({super.key});
  final FileManagement fileManagement = Get.find();

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    // child: GetBuilder<FileManagement>(
    //   builder: (_) {
    //     return ListView.builder(
    //       itemCount: fileManagement.hashMap.length,
    //       itemBuilder: (context, index) {
    //         if (fileManagement.hashMap.values.elementAt(index).length > 1) {
    //           return ShowFileDetails(
    //             fileList: fileManagement.hashMap.values.elementAt(index),
    //           );
    //         }
    //       },
    //     );
    //   },
    // ),
    // );
    return Container();
  }
}

class ShowFileDetails extends StatelessWidget {
  final List<String> fileList;
  const ShowFileDetails({super.key, required this.fileList});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: null,
      alignment: null,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fileList.length.toString()),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: fileList.map((e) => Text("# $e")).toList()),
          ],
        ),
      ),
    );
  }
}
