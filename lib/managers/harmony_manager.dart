import 'package:flutter_music_application/constants.dart';

class HarmonyManager {
  double calculateFontSize (int lastChordLimit) => Constants.maxOutputFont - (lastChordLimit - Constants.maxChordLimit) * (Constants.maxOutputFont - Constants.minOutputFont) / (Constants.maxChordLimit - Constants.minChordLimit);

  void generateProgression() {
    
  }
}