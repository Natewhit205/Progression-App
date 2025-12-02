import 'package:flutter/material.dart';
import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:flutter_music_application/widgets/chord_cell.dart';

class ChordDisplay {
  late List<List<Chord?>> displayArray;

  void addChord(Chord chord) {
    int index = displayArray.length - 1;

    if (displayArray[index].last != null) {
      displayArray.add([]);
      index += 1;

      for (int i = 0; i < Constants.chordsPerLine; i++) {
        displayArray[index].add(null);
      }

      print('New Row: $displayArray');
    }

    for (int i = 0; i <= Constants.chordsPerLine; i++) {
      print('Display index: $i\n');
      print('Chord: ${displayArray[index][i]}');
      if (displayArray[index][i] == null) {
        displayArray[index][i] = chord;
        break;
      }
    }

    print(displayArray);
  }

  void init() {
    clearDisplay();
  }

  void clearDisplay() {
    displayArray = [[]];
    for (int i = 0; i < Constants.chordsPerLine; i++) {
      displayArray[0].add(null);
    }
  }

  List<ChordCell> getDisplay() {
    print(displayArray);
    List<ChordCell> widgets = [];

    for (List<Chord?> row in displayArray) {
      for (Chord? chord in row) {
        if (chord == null) {
          widgets.add(const ChordCell(
            name: '',
          ));
        } else {
          widgets.add(ChordCell(
            name: chord.chordName,
          ));
        }
      }
    }

    debugPrint('Widgets: $widgets');

    return widgets;
  }
}