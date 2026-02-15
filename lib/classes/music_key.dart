import 'package:flutter_music_application/classes/chord.dart';

class MusicKey {
  final String keyName;
  final Map<String, int> chordIndex = {};
  final List<Chord> chords = [];

  MusicKey(this.keyName, List<Map> chordsJson) {
    _populateChords(chordsJson);
  }

  void _populateChords(List<Map> chords) {
    for (final chord in chords) {
      int chordId = chord["chordId"];
      String chordName = chord["chordName"];
      String keyName = this.keyName;
      bool enabled = chord["enabled"];

      // Parse Transitions
      final List<Transition> transitions = [];
      final transitionJson = chord["chordTransitions"];

      if (transitionJson != null) {
        final ids = List<int>.from(transitionJson["transitionId"]);
        final names = List<String>.from(transitionJson["transitionName"]);
        final weights = List<num>.from(transitionJson["weights"]);

        final len = [ids.length, names.length, weights.length].reduce((a, b) => a < b ? a : b);

        for (int i = 0; i < len; i++) {
          transitions.add(
            Transition(
              transitionId: ids[i],
              transitionName: names[i],
              weight: weights[i].toDouble()
            ),
          );
        }
      }

      // Parse Modulations
      final List<Modulation> modulations = [];
      final modJson = chord["modulations"];

      if (modJson != null) {
        for (final m in modJson) {
          modulations.add(
            Modulation(
              keyName: m["modKey"],
              chordName: m["modChord"],
              weight: (m["modWeight"] as num).toDouble(),
            ),
          );
        }
      }

      // Add Chord Object
      final chordObj = Chord(
        chordId: chordId,
        chordName: chordName,
        keyName: keyName,
        enabled: enabled,
        chordTransitions: transitions,
        modulations: modulations
      );

      this.chords.add(chordObj);
      chordIndex[chordName] = chordId;
    }
  }

  Chord getChordObj(String chordName) {
    final int? chordId = chordIndex[chordName];
    
    if (chordId == null) {
      throw Exception("Chord not found in key $keyName: $chordName");
    }

    assert(chordId >= 0 && chordId < chords.length);
    Chord chordObj = chords.elementAt(chordId);
    return chordObj;
  }
}