import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class Constants {
  static AppBar customAppBar({String? title}) => AppBar(
    foregroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        Image.asset(
          'assets/icons/logo_filled.png',
          height: 60,
        )
      ]
    ),
    backgroundColor: AppTheme.primary40,
  );
}