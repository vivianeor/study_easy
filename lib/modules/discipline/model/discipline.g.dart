// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discipline.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DisciplineAdapter extends TypeAdapter<Discipline> {
  @override
  final int typeId = 4;

  @override
  Discipline read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Discipline(
      name: fields[1] as String,
      nota1: fields[5] as double?,
      nota2: fields[6] as double?,
      nota3: fields[7] as double?,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Discipline obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.nota1)
      ..writeByte(6)
      ..write(obj.nota2)
      ..writeByte(7)
      ..write(obj.nota3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisciplineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
