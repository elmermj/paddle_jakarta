// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchModelAdapter extends TypeAdapter<MatchModel> {
  @override
  final int typeId = 2;

  @override
  MatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchModel(
      matchId: fields[0] as String?,
      creatorId: fields[1] as String?,
      createdAt: fields[2] as Timestamp?,
      matchDate: fields[3] as Timestamp?,
      latitude: fields[4] as double?,
      longitude: fields[5] as double?,
      locationName: fields[6] as String?,
      teams: (fields[7] as List?)
          ?.map((dynamic e) => (e as List?)?.cast<UserModel>())
          ?.toList(),
      refereeId: fields[8] as String?,
      teamScores: (fields[9] as List?)
          ?.map((dynamic e) => (e as List).cast<int>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, MatchModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.matchId)
      ..writeByte(1)
      ..write(obj.creatorId)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.matchDate)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
      ..writeByte(6)
      ..write(obj.locationName)
      ..writeByte(7)
      ..write(obj.teams)
      ..writeByte(8)
      ..write(obj.refereeId)
      ..writeByte(9)
      ..write(obj.teamScores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
