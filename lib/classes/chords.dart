// class Chord {
//   String name;
//   List<String> transitions;

//   Chord(this.name, this.transitions);
// }

// class Chords {
//   Map<String, Chord> vertices;

//   Chords(this.vertices);

//   addChord(Chord chord) {
//     vertices[chord.name] = chord;
//   }
// }

// import 'chord.dart';

// class ChordTransition {
//   String from;
//   String to;

//   ChordTransition(this.from, this.to);
// }

// class Chord {
//   String name;

//   Chord(this.name);
// }

// class ChordTracker {
//   Chord currentChord;

//   Map<String, Chord> chords = {};
//   Map<String, Map<String, int>> transitions = {};

//   ChordTracker(this.currentChord) {
//     chords[currentChord.name] = currentChord;
//   }

//   nextChord(Chord chord) {
//     Map<String, int> currentTransitions = transitions[currentChord.name] ?? {};
//     int transitionCount = (currentTransitions[chord.name] ?? 0) + 1;
//     currentTransitions[currentChord.name] = transitionCount;
//     transitions[currentChord.name] = currentTransitions;

//     chords[chord.name] = chord;
//   }

//   List<(String, double)> transitionsForChord(Chord chord) {
//     Map<String, int>? chordTransitions = transitions[chord.name];

//     if (chordTransitions == null) {
//       return [];
//     }

//     int total = chordTransitions.values.reduce((acc, n) => acc + n);

//     return chordTransitions.entries.map((MapEntry<String, int> entry) => (entry.key, entry.value.toDouble() / total.toDouble())).toList();
//   }
// }

import 'package:dart_random_choice/dart_random_choice.dart';

class Chord {
  int chordId;
  String name;
  List<(String, double)> transitionWeights;

  Chord(this.chordId, this.name, this.transitionWeights);
}

class Chords {
  Map<String, Chord> chords;

  Chords(this.chords);

  addChord(Chord chord) {
    chords[chord.name] = chord;
  }

  Chord? findNextChord(Chord from) {
    if (from.transitionWeights.isEmpty) {
      return null;
    }

    String next = randomChoice(from.transitionWeights.map((t) => t.$1), from.transitionWeights.map((t) => t.$2));

    return chords[next];
  }
}