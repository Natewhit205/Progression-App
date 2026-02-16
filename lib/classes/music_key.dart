import 'package:hive/hive.dart';
import 'package:flutter_music_application/classes/chord.dart';

part 'music_key.g.dart';

@HiveType(typeId: 3)
class MusicKey {
  @HiveField(0)
  final String keyName;

  @HiveField(1)
  final Map<String, int> chordIndex;

  @HiveField(2)
  final List<Chord> chords;

  MusicKey(this.keyName, this.chordIndex, this.chords);

  factory MusicKey.fromJson(String keyName, List<Map> chordsJson) {
    final chordIndex = <String, int>{};
    final chords = <Chord>[];

    for (final chord in chordsJson) {
      int chordId = chord["chordId"];
      String chordName = chord["chordName"];
      bool enabled = chord["enabled"];

      // Parse Transitions
      final List<Transition> transitions = [];
      final transitionJson = chord["chordTransitions"];

      if (transitionJson != null) {
        final ids = List<int>.from(transitionJson["transitionId"]);
        final names = List<String>.from(transitionJson["transitionName"]);
        final weights = List<num>.from(transitionJson["weights"]);

        final len = [ids.length, names.length, weights.length]
          .reduce((a, b) => a < b ? a : b);

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

      chords.add(chordObj);
      chordIndex[chordName] = chordId;
    }

    return MusicKey(keyName, chordIndex, chords);
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