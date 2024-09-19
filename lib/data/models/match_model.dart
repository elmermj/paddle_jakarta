import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';

part 'match_model.g.dart';

@HiveType(typeId: 2)
class MatchModel extends HiveObject{
  @HiveField(0)
  final String? matchId;
  @HiveField(1)
  final String? creatorId;
  @HiveField(2)
  final Timestamp? createdAt;
  @HiveField(3)
  final Timestamp? matchDate;
  @HiveField(4)
  final double? latitude;
  @HiveField(5)
  final double? longitude;
  @HiveField(6)
  final String? locationName;
  @HiveField(7)
  final List<List<UserModel>?>? teams;
  @HiveField(8)
  final String? refereeId;
  @HiveField(9)
  final List<List<int>>? teamScores;

  MatchModel({
    this.matchId,
    this.creatorId,
    this.createdAt,
    this.matchDate,
    this.latitude,
    this.longitude,
    this.locationName,
    this.teams,
    this.refereeId,
    this.teamScores,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['matchId'],
      creatorId: json['creatorId'],
      createdAt: json['createdAt'],
      matchDate: json['matchDate'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationName: json['locationName'],
      teams: (json['teams'] as List<dynamic>?)
          ?.map((team) => (team as List<dynamic>?)
              ?.map((player) => UserModel.fromJson(player as Map<String, dynamic>))
              .toList())
          .toList(),
      refereeId: json['refereeId'],
      teamScores: (json['teamScores'] as List<dynamic>?)
          ?.map((score) => (score as List<dynamic>)
              .map((s) => s as int)
              .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'creatorId': creatorId,
      'createdAt': createdAt,
      'matchDate': matchDate,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'teams': teams
          ?.map((team) => team?.map((player) => player.toJson()).toList())
          .toList(),
      'refereeId': refereeId,
      'teamScores': teamScores?.map((round) => round.map((score) => score).toList()).toList(),
    };
  }
}