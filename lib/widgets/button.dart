import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;

  // Constant Values
  final Color? color = const Color.fromARGB(255, 42, 85, 124);
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  final Color? textColor = const Color(0xfffffdfd);
  final double? height = 40;
  final double? minWidth = 110;
  final EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    this.child
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