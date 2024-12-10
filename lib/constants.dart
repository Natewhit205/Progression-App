import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';

class Constants {
  static AppBar defaultAppBar = AppBar(
    foregroundColor: Colors.white,
    title: const Text(
      'Progression',
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: AppTheme.primary,
  );

  static AppBar chordChartsAppBar = AppBar(
    foregroundColor: Colors.white,
    title: const Text(
      'Chord Charts',
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: AppTheme.primary,
  );

  static AppBar savesAppBar = AppBar(
    foregroundColor: Colors.white,
    title: const Text(
      'Saved Progressions',
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: AppTheme.primary,
  );
}