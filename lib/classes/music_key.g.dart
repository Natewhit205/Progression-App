// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicKeyAdapter extends TypeAdapter<MusicKey> {
  @override
  final int typeId = 3;

  @override
  MusicKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicKey(
      fields[0] as String,
      (fields[1] as Map).cast<String, int>(),
      (fields[2] as List).cast<Chord>(),
    );
  }

  @override
  void write(BinaryWriter writer, MusicKey obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.keyName)
      ..writeByte(1)
      ..write(obj.chordIndex)
      ..writeByte(2)
      ..write(obj.chords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
