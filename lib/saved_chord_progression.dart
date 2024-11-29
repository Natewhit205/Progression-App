import 'package:hive/hive.dart';
part 'saved_chord_progression.g.dart';

@HiveType(typeId: 1)
class SavedChordProgression {
  @HiveField(0)
  List<String> chordProgression;

  SavedChordProgression(this.chordProgression);
}