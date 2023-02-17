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
    this.borderRadius = const BorderRadius.all(Radius.circular(defaultBorderRadius)),
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
        child: fileManagement.isRunning
            ? Stack(
                children: [
                  if (fileManagement.totalFileSize != 0)
                    Positioned.fill(
                        child: LinearProgressIndicator(
                      value: fileManagement.readFileSize / fileManagement.totalFileSize,
                    )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          fileManagement.currentFile != null ? fileManagement.currentFile!.split(fileManagement.path ?? "").last : "",
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).canvasColor),
                        )),
                        const SizedBox(width: defaultPadding / 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: defaultPadding,
                              width: defaultPadding,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: CircularProgressIndicator(
                                  strokeWidth: defaultPadding / 6,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Text(
                              "${fileManagement.itemCount}/${fileManagement.pathItems.length}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Theme.of(context).canvasColor, height: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : null,
      );
    });
  }
}
