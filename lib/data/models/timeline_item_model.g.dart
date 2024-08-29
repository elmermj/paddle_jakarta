// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimelineItemModelAdapter extends TypeAdapter<TimelineItemModel> {
  @override
  final int typeId = 4;

  @override
  TimelineItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimelineItemModel(
      timelineItemId: fields[0] as String?,
      title: fields[1] as String?,
      type: fields[2] as String?,
      timestamp: fields[3] as Timestamp?,
    );
  }

  @override
  void write(BinaryWriter writer, TimelineItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timelineItemId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimelineItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
