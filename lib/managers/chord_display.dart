import 'package:flutter/material.dart';
import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/widgets/chord_cell.dart';

class ChordDisplay {
  late List<ChordData> displayArray;
  int defaultDisplaySize = 16;

  void addChord(ChordData chord) => displayArray.add(chord);

  void init() {
    clearDisplay();
  }

  void clearDisplay() {
    displayArray = [];
  }

  List<ChordData?> addNulls(List<ChordData?> array, int numOfNulls) {
    List<ChordData?> output = List.from(array);
    for (int i = 0; i < numOfNulls; i++) {
      output.add(null);
    }
    return output;
  }

  List<ChordCell> getDisplay() {
    List<ChordCell> widgets = [];
    int number = 1;    
    List<ChordData?> temporaryArray = displayArray;
    int length = temporaryArray.length;

    if (length < defaultDisplaySize) {
      int difference = defaultDisplaySize - length;
      temporaryArray = addNulls(temporaryArray, difference);
    } else if (length > defaultDisplaySize) {
      int multiplier = 1;

      while (true) {
        int newMax = (defaultDisplaySize + 4 * multiplier);
        if (length < newMax) {
          int difference =  newMax - length;
          temporaryArray = addNulls(temporaryArray, difference);
          break;
        }
        multiplier++;
      }
    }

    for (ChordData? chord in temporaryArray) {
      if (chord == null) {
        widgets.add(ChordCell(
          number: number,
          name: '',
        ));
      } else {
        widgets.add(ChordCell(
          number: number,
          name: chord.chordName,
        ));
      }
      number++;
    }

    debugPrint('Widgets: $widgets');

    return widgets;
  }
}