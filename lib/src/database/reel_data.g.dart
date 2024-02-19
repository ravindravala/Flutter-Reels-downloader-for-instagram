// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReelDataAdapter extends TypeAdapter<ReelData> {
  @override
  final int typeId = 1;

  @override
  ReelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReelData()
      ..downloadLink = fields[0] as String?
      ..imageLink = fields[1] as String?
      ..storagePath = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, ReelData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.downloadLink)
      ..writeByte(1)
      ..write(obj.imageLink)
      ..writeByte(2)
      ..write(obj.storagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
