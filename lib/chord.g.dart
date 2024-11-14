// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChordAdapter extends TypeAdapter<Chord> {
  @override
  final int typeId = 0;

  @override
  Chord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chord(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List).cast<int>(),
      (fields[3] as List).cast<String>(),
      fields[4] as bool,
      (fields[5] as Map).cast<int, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Chord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.chordName)
      ..writeByte(2)
      ..write(obj.nextChords)
      ..writeByte(3)
      ..write(obj.nextChordNames)
      ..writeByte(4)
      ..write(obj.modulates)
      ..writeByte(5)
      ..write(obj.keyShifts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
