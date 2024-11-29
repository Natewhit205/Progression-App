import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class TunerButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? height;
  final double? minWidth;
  final Widget? child;
  final Color? color;

  // Constant Values
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
  final Color? textColor = Colors.white;
  final EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  const TunerButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.height,
    required this.minWidth,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: shape,
      textColor: textColor,
      height: height,
      minWidth: minWidth,
      padding: padding,
      child: child,
    );
  }
}