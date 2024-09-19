import 'package:flutter_test/flutter_test.dart';
import 'package:paddle_jakarta/data/models/statistics_model.dart';

void main() {
  group('StatisticsModel', () {
    test('should create a StatisticsModel with all fields', () {
      final model = StatisticsModel(
        userId: 'user123',
        wins: 10,
        losses: 5,
        draws: 2,
        matchesPlayed: 17,
        points: 32,
      );

      expect(model.userId, 'user123');
      expect(model.wins, 10);
      expect(model.losses, 5);
      expect(model.draws, 2);
      expect(model.matchesPlayed, 17);
      expect(model.points, 32);
    });

    test('should create a StatisticsModel from JSON', () {
      final json = {
        'userId': 'user456',
        'wins': 15,
        'losses': 8,
        'draws': 3,
        'matchesPlayed': 26,
        'points': 48,
      };

      final model = StatisticsModel.fromJson(json);

      expect(model.userId, 'user456');
      expect(model.wins, 15);
      expect(model.losses, 8);
      expect(model.draws, 3);
      expect(model.matchesPlayed, 26);
      expect(model.points, 48);
    });

    test('should convert StatisticsModel to JSON', () {
      final model = StatisticsModel(
        userId: 'user789',
        wins: 20,
        losses: 10,
        draws: 5,
        matchesPlayed: 35,
        points: 65,
      );

      final json = model.toJson();

      expect(json['userId'], 'user789');
      expect(json['wins'], 20);
      expect(json['losses'], 10);
      expect(json['draws'], 5);
      expect(json['matchesPlayed'], 35);
      expect(json['points'], 65);
    });

    test('should handle null values when creating from JSON', () {
      final json = {
        'userId': null,
        'wins': null,
        'losses': null,
        'draws': null,
        'matchesPlayed': null,
        'points': null,
      };

      final model = StatisticsModel.fromJson(json);

      expect(model.userId, 'N/A');
      expect(model.wins, 0);
      expect(model.losses, 0);
      expect(model.draws, 0);
      expect(model.matchesPlayed, 0);
      expect(model.points, 0);
    });

    test('should handle null values when converting to JSON', () {
      final model = StatisticsModel();

      final json = model.toJson();

      expect(json['userId'], 'N/A');
      expect(json['wins'], 0);
      expect(json['losses'], 0);
      expect(json['draws'], 0);
      expect(json['matchesPlayed'], 0);
      expect(json['points'], 0);
    });
  });
}
