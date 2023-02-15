import 'package:find_duplicate/styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.margin = const EdgeInsets.all(defaultMargin),
    this.alignment = Alignment.center,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    this.boxShadow = defaultShadow,
    this.child,
    this.height = defaultBoxHeight,
  });
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
