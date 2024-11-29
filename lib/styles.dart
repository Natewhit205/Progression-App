import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle standard(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle emphasised(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle large(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle medium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle small(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle bold(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle heading(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }

  static TextStyle setSize(BuildContext context, {Color? color, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color ?? Colors.white,
    );
  }
}