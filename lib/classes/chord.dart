import 'package:hive/hive.dart';

part 'chord.g.dart';

@HiveType(typeId: 4)
class Chord {
  @HiveField(0)
  final int chordId;

  @HiveField(1)
  final String chordName;

  @HiveField(2)
  final String keyName;

  @HiveField(3)
  final bool enabled;

  @HiveField(4)
  final List<Transition> chordTransitions;

  @HiveField(5)
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

@HiveType(typeId: 5)
class Transition {
  @HiveField(0)
  final int transitionId;

  @HiveField(1)
  final String transitionName;

  @HiveField(2)
  final double weight;

  Transition({
    required this.transitionId,
    required this.transitionName,
    required this.weight
  });
}

@HiveType(typeId: 6)
class Modulation {
  @HiveField(0)
  final String keyName;

  @HiveField(1)
  final String chordName;

  @HiveField(2)
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