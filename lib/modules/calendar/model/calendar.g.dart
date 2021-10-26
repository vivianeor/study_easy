// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarAdapter extends TypeAdapter<Calendar> {
  @override
  final int typeId = 0;

  @override
  Calendar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calendar(
      date: fields[2] as DateTime?,
      name: fields[1] as String,
      nameDiscipline: fields[3] as String?,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Calendar obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.nameDiscipline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
