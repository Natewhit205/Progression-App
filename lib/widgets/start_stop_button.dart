import 'package:flutter/material.dart';

class StartStopButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? color;

  // Constant Values
  final double? height = 10;
  final double? minWidth = 120;
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
  final Color? textColor = Colors.white;
  final EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  const StartStopButton({
    super.key,
    required this.onPressed,
    required this.color,
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