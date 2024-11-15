import 'dart:math';

import 'package:hive/hive.dart';
part 'chord.g.dart';

@HiveType(typeId: 0)
class Chord {
  @HiveField(0)
  int iD;

  @HiveField(1)
  String chordName;

  @HiveField(2)
  List<int> nextChords;

  @HiveField(3)
  List<String> nextChordNames;

  @HiveField(4)
  bool modulates = false;

  @HiveField(5)
  Map<int, int> keyShifts = {};

  Chord(this.iD, this.chordName, this.nextChords, this.nextChordNames, this.modulates, this.keyShifts);

  List<int> getPossibleChords() {
    List<int> output = nextChords;

    if (modulates) {
      output.add(-1);
      /* -1 will represent choosing to modulate to another key.
      After selecting to do so the system will then pull a random
      chord and key from the keyShifts Map */
    }

    return output;
  }

  String getModulation() {
    int index = Random().nextInt(keyShifts.length);
    int key = keyShifts.keys.elementAt(index);
    int value = keyShifts[key]!;
    return '[$key, $value]';
  }
}