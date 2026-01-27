import 'package:flutter_music_application/chord.dart';

class ChordProgression {
  List<Chord> chords = [];

  int addChord(Chord? chord) {
    if (chord != null) {
      chords.add(chord);
      return 0;
    }
    return -1;
  }
}