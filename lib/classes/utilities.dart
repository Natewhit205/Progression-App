import 'package:flutter_music_application/constants.dart';

class Utilities {
  static double calculateFontSize (int lastChordLimit) {
    final range = Constants.maxChordLimit - Constants.minChordLimit;
    assert(range != 0);
    
    return Constants.maxOutputFont -
      (lastChordLimit - Constants.maxChordLimit) *
        (Constants.maxOutputFont - Constants.minOutputFont) /
        range;
  }
}