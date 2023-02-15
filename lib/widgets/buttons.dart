import 'package:find_duplicate/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    super.key,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: defaultPadding),
    this.margin = const EdgeInsets.all(defaultMargin),
    this.color,
    this.boxShadow = defaultShadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    this.child,
    this.onLoading = const AspectRatio(aspectRatio: 1, child: CircularProgressIndicator(color: Colors.white)),
    this.onSuccess = const FittedBox(child: FaIcon(FontAwesomeIcons.check, color: Colors.greenAccent)),
    this.onError = const FittedBox(child: FaIcon(FontAwesomeIcons.exclamation, color: Colors.redAccent)),
    this.onTap,
    this.defaultDuration = 3000,
    this.height = defaultBoxHeight,
  });
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final Widget? onLoading;
  final Widget? onSuccess;
  final Widget? onError;
  final Function()? onTap;
  final int defaultDuration;
  final double? height;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  LoadingButtonState loadingButtonState = LoadingButtonState.stable;

  Widget? childHolder() {
    if (loadingButtonState == LoadingButtonState.loading) return widget.onLoading;
    if (loadingButtonState == LoadingButtonState.success) return widget.onSuccess;
    if (loadingButtonState == LoadingButtonState.error) return widget.onError;
    return widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      child: Material(
        color: widget.color ?? Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () async {
            if (loadingButtonState != LoadingButtonState.stable) return;
            if (widget.onTap == null) return;
            setState(() => loadingButtonState = LoadingButtonState.loading);
            bool? res = await widget.onTap!();
            // res has value
            if (res == null) {
              setState(() => loadingButtonState = LoadingButtonState.stable);
              return;
            } else {
              if (res && widget.onLoading != null) {
                setState(() => loadingButtonState = LoadingButtonState.success);
                await Future.delayed(Duration(milliseconds: widget.defaultDuration));
              } else if (!res && widget.onError != null) {
                setState(() => loadingButtonState = LoadingButtonState.error);
                await Future.delayed(Duration(milliseconds: widget.defaultDuration));
              }
            }
            setState(() => loadingButtonState = LoadingButtonState.stable);
          },
          child: Container(
            height: widget.height,
            alignment: widget.alignment,
            padding: widget.padding,
            child: childHolder(),
          ),
        ),
      ),
    );
  }
}

enum LoadingButtonState {
  stable,
  loading,
  success,
  error,
}
