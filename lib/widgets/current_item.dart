import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/styles.dart';
import 'package:find_duplicate/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentItem extends StatelessWidget {
  CurrentItem({
    super.key,
    this.child,
    this.defaultDuration = 150,
    this.height = defaultBoxHeight,
    this.boxShadow = defaultShadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.all(defaultMargin),
    this.backgroundColor = Colors.white,
  });
  final Widget? child;
  final int defaultDuration;
  final double height;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;

  final FileManagement fileManagement = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileManagement>(builder: (_) {
      return CustomCard(
        height: null,
        // child: fileManagement.isRunning
        //     ? Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
        //         child: Row(
        //           children: [
        //             Expanded(child: Text(fileManagement.currentFile != null ? fileManagement.currentFile!.split('/').last : "")),
        //             const SizedBox(width: defaultPadding / 2),
        //             Column(
        //               children: [
        //                 const SizedBox(
        //                   height: defaultPadding,
        //                   width: defaultPadding,
        //                   child: AspectRatio(
        //                     aspectRatio: 1,
        //                     child: CircularProgressIndicator(strokeWidth: defaultPadding / 6),
        //                   ),
        //                 ),
        //                 const SizedBox(height: defaultPadding / 2),
        //                 Text(
        //                   fileManagement.itemCount.toString(),
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(fontSize: 12),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       )
        //     : null,
      );
    });
  }
}


// child: CustomCard(
//           height: null,
//           child: fileManagement.isRunning
//               ? Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(fileManagement.currentFile != null ? fileManagement.currentFile!.split('/').last : ""),
//                       const SizedBox(width: defaultPadding / 2),
//                       if (fileManagement.isRunning)
//                         const Padding(
//                           padding: EdgeInsets.symmetric(vertical: defaultPadding / 1.5),
//                           child: AspectRatio(
//                             aspectRatio: 1,
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),
//                     ],
//                   ),
//                 )
//               : Container(),
//         ),