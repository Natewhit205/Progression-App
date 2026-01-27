import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/classes/chord_progression.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class HarmonyManager {
  double calculateFontSize (int lastChordLimit) => Constants.maxOutputFont - (lastChordLimit - Constants.maxChordLimit) * (Constants.maxOutputFont - Constants.minOutputFont) / (Constants.maxChordLimit - Constants.minChordLimit);

  ChordProgression generateChordProgression(Chord startingChord, int numberOfChords) {
    ChordProgression progression = ChordProgression();
    progression.addChord(startingChord);
    _recursiveChordGenerate(progression, numberOfChords);
    return progression;
  }

  void _recursiveChordGenerate(ChordProgression chordProgression, int num) {
    if (num > 0) {
      Chord nextChord = findNextChord(chordProgression.chords.last);
      chordProgression.addChord(nextChord);
      num--;

      _recursiveChordGenerate(chordProgression, num);
    }
  }

  Chord findNextChord(Chord chord) {
    final (options, weights) = chord.getPossibleChords();
    Chord next = randomChoice<Chord>(options, weights);
    return next;
  }
}