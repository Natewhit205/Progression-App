import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class Constants {
  static AppBar appBar = AppBar(
    foregroundColor: Colors.white,
    title: const Text(
      'Progression',
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: AppTheme.primary,
  );
}