import 'package:hive/hive.dart';
part 'chord.g.dart';

@HiveType(typeId: 0)
class Chord {
  @HiveField(0)
  int iD;

  @HiveField(1)
  List<int> nextChords;

  @HiveField(2)
  List<String> nextChordNames;

  @HiveField(3)
  bool modulates = false;

  @HiveField(4)
  Map keyShifts = {};

  Chord(this.iD, this.nextChords, this.nextChordNames, this.modulates, this.keyShifts);
}