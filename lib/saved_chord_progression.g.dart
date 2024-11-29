// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_chord_progression.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedChordProgressionAdapter extends TypeAdapter<SavedChordProgression> {
  @override
  final int typeId = 1;

  @override
  SavedChordProgression read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedChordProgression(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedChordProgression obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.chordProgression);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedChordProgressionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
