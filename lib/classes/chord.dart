class Chord {
  final int chordId;
  final String chordName;
  final String keyName;
  final bool enabled;
  final List<Transition> chordTransitions;
  final List<Modulation> modulations;

  Chord({
    required this.chordId,
    required this.chordName,
    required this.keyName,
    required this.enabled,
    required this.chordTransitions,
    required this.modulations
  });

  List<ChordData> getPossibleChords() {
    List<ChordData> options = [];

    for (final t in chordTransitions) {
      options.add(
        ChordData(
          keyName: keyName,
          chordName: t.transitionName,
          weight: t.weight
        )
      );
    }

    for (final m in modulations) {
      options.add(
        ChordData(
          keyName: m.keyName,
          chordName: m.chordName,
          weight: m.weight
        )
      );
    }

    return options;
  }
}

class Transition {
  final int transitionId;
  final String transitionName;
  final double weight;

  Transition({
    required this.transitionId,
    required this.transitionName,
    required this.weight
  });
}

class Modulation {
  final String keyName;
  final String chordName;
  final double weight;

  Modulation({
    required this.keyName,
    required this.chordName,
    required this.weight
  });
}

class ChordData {
  final String keyName;
  final String chordName;
  final double weight;

  ChordData({
    required this.keyName,
    required this.chordName,
    required this.weight
  });
}