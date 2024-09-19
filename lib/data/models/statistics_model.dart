import 'package:hive_flutter/hive_flutter.dart';

part 'statistics_model.g.dart';
@HiveType(typeId: 3)
class StatisticsModel extends HiveObject{
  @HiveField(0)
  String? userId;
  @HiveField(1)
  int? wins;
  @HiveField(2)
  int? losses;
  @HiveField(3)
  int? draws;
  @HiveField(4)
  int? matchesPlayed;
  @HiveField(5)
  int? points;


  StatisticsModel({
    this.userId,
    this.wins,
    this.losses,
    this.draws,
    this.matchesPlayed,
    this.points,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      userId: json['userId'] ?? 'N/A',
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      matchesPlayed: json['matchesPlayed'] ?? 0,
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId ?? 'N/A',
      'wins': wins ?? 0,
      'losses': losses ?? 0,
      'draws': draws ?? 0,
      'matchesPlayed': matchesPlayed ?? 0,
      'points': points ?? 0,
    };
  }
}