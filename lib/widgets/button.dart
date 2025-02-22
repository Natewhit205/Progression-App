import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class CustomMaterialButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;

  // Constant Values
  final Color? color = AppTheme.secondary90;
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  final Color? textColor = AppTheme.secondary10;
  final double? height = 30;
  final double? minWidth = 100;
  final EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth,
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        shape: shape,
        textColor: textColor,
        height: height,
        minWidth: minWidth,
        padding: padding,
        child: child,
      )
    );
  }
}

class SimpleActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? color;

  // Constant Values
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  final Color? textColor = Colors.white;
  final double? height = 45;
  final double? minWidth = 130;
  final EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  const SimpleActionButton({
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