import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/classes/chord_progression.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class HarmonyManager {
  ChordMap chordMap;

  HarmonyManager({required this.chordMap});

  ChordProgression generateChordProgression(ChordData startingChord, int numberOfChords) {
    ChordProgression progression = ChordProgression();
    progression.addChord(startingChord);
    _recursiveChordGenerate(progression, numberOfChords - 1);
    return progression;
  }

  ChordData getChordDataObj(int selectedKey, int selectedChord) {
    String keyName = _getKeyName(selectedKey);
    String chordName = _getChordName(selectedChord, selectedKey);
    return ChordData(keyName: keyName, chordName: chordName, weight: 0);
  }

  String _getKeyName(int keyId) {
    return chordMap.mapKeys[keyId].keyName;
  }

  String _getChordName(int chordId, int keyId) {
    return chordMap.mapKeys[keyId].chords[chordId].chordName;
  }

  void _recursiveChordGenerate(ChordProgression chordProgression, int num) {
    assert(num >= 0);
    assert(chordProgression.chords.isNotEmpty);

    if (num > 0) {
      final ChordData lastChord = chordProgression.chords.last;
      Chord chordObj = chordMap.getChordObj(lastChord.keyName, lastChord.chordName);
      ChordData? nextChord = _findNextChord(chordObj);

      if (nextChord == null) {
        return;
      }

      chordProgression.addChord(nextChord);
      num--;

      _recursiveChordGenerate(chordProgression, num);
    }
  }

  ChordData? _findNextChord(Chord chord) {
    final List<ChordData> options = chord.getPossibleChords();
    if (options.isEmpty) return null;

    final List<double> weights = options.map((o) => o.weight).toList();

    return randomChoice<ChordData>(options, weights);
  }
}