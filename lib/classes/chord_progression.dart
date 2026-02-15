import 'package:flutter_music_application/classes/chord.dart';

class ChordProgression {
  final List<ChordData> chords = [];

  int addChord(ChordData? chord) {
    if (chord != null) {
      chords.add(chord);
      return 0;
    }
    return -1;
  }
}