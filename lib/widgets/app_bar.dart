import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class CustomAppBar {
  static AppBar customAppBar({String? title}) => AppBar(
    foregroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(
            color: AppTheme.primary30,
            fontWeight: FontWeight.w800,
          ),
        )
      ]
    ),
    backgroundColor: AppTheme.surface,
  );
}