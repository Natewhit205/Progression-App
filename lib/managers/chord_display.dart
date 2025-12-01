import 'package:flutter_music_application/chord.dart';

class ChordDisplay {
  int chordsPerLine = 4;
  List<List<Chord?>> displayArray = [[null, null, null, null]];

  void addChord(Chord chord) {
    int arrayLength = displayArray.length;
    int index = arrayLength - 1;

    if (displayArray[index].last != null) {
      displayArray.add([]);
      index += 1;
    }

    for (int i = 0; i < chordsPerLine; i++) {
      if (displayArray[index][i] == null) {
        displayArray[index][i] = chord;
        break;
      }
    }
  }

  void clearDisplay() {
    displayArray = [[null, null, null, null]];
  }
}