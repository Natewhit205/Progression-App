// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord_map.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChordMapAdapter extends TypeAdapter<ChordMap> {
  @override
  final int typeId = 2;

  @override
  ChordMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChordMap(
      fields[0] as String,
      (fields[1] as Map).cast<String, int>(),
    )..mapKeys = (fields[2] as List).cast<MusicKey>();
  }

  @override
  void write(BinaryWriter writer, ChordMap obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mapName)
      ..writeByte(1)
      ..write(obj.keyIndex)
      ..writeByte(2)
      ..write(obj.mapKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChordMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
