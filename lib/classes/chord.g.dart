// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChordAdapter extends TypeAdapter<Chord> {
  @override
  final int typeId = 4;

  @override
  Chord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chord(
      chordId: fields[0] as int,
      chordName: fields[1] as String,
      keyName: fields[2] as String,
      enabled: fields[3] as bool,
      chordTransitions: (fields[4] as List).cast<Transition>(),
      modulations: (fields[5] as List).cast<Modulation>(),
    );
  }

  @override
  void write(BinaryWriter writer, Chord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.chordId)
      ..writeByte(1)
      ..write(obj.chordName)
      ..writeByte(2)
      ..write(obj.keyName)
      ..writeByte(3)
      ..write(obj.enabled)
      ..writeByte(4)
      ..write(obj.chordTransitions)
      ..writeByte(5)
      ..write(obj.modulations);
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

class TransitionAdapter extends TypeAdapter<Transition> {
  @override
  final int typeId = 5;

  @override
  Transition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transition(
      transitionId: fields[0] as int,
      transitionName: fields[1] as String,
      weight: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Transition obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.transitionId)
      ..writeByte(1)
      ..write(obj.transitionName)
      ..writeByte(2)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ModulationAdapter extends TypeAdapter<Modulation> {
  @override
  final int typeId = 6;

  @override
  Modulation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Modulation(
      keyName: fields[0] as String,
      chordName: fields[1] as String,
      weight: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Modulation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.keyName)
      ..writeByte(1)
      ..write(obj.chordName)
      ..writeByte(2)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModulationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
