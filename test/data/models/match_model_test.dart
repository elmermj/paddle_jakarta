import 'package:flutter_test/flutter_test.dart';
import 'package:paddle_jakarta/data/models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('MatchModel', () {
    late Map<String, dynamic> json;

    setUp(() {
      json = {
        'matchId': '1',
        'teams': [
          [
            {
              'displayName': 'Player A',
              'email': 'playerA@example.com',
              'photoUrl': 'https://example.com/playerA.jpg'
            },
            {
              'displayName': 'Player B',
              'email': 'playerB@example.com',
              'photoUrl': 'https://example.com/playerB.jpg'
            }
          ],
          [
            {
              'displayName': 'Player C',
              'email': 'playerC@example.com',
              'photoUrl': 'https://example.com/playerC.jpg'
            },
            {
              'displayName': 'Player D',
              'email': 'playerD@example.com',
              'photoUrl': 'https://example.com/playerD.jpg'
            }
          ]
        ],
        'teamScores': [
          [2, 1],
          [3, 1],
          [1, 3],
        ],
        'matchDate': Timestamp.now(),
        'createdAt': Timestamp.now(),
        'refereeId': 'referee123@example.com',
        'creatorId': 'creator456@example.com',
        'latitude': 123.456,
        'longitude': 45.012,
        'locationName': 'Jakarta',
      };
    });

    test('should convert JSON to MatchModel and verify field values', () {
      // Act
      final match = MatchModel.fromJson(json);

      // Assert
      expect(match.matchId, '1');
      expect(match.creatorId, 'creator456@example.com');
      expect(match.latitude, 123.456);
      expect(match.longitude, 45.012);
      expect(match.locationName, 'Jakarta');
      expect(match.teams![0]![0].displayName, 'Player A');
      expect(match.teams![0]![1].displayName, 'Player B');
      expect(match.teams![1]![0].displayName, 'Player C');
      expect(match.teams![1]![1].displayName, 'Player D');
      expect(match.teamScores![0][0], 2);
      expect(match.teamScores![0][1], 1);
      expect(match.teamScores![1][0], 3);
      expect(match.teamScores![1][1], 1);
      expect(match.teamScores![2][0], 1);
      expect(match.teamScores![2][1], 3);
    });

    test('should convert MatchModel to JSON', () {
      // Arrange
      final match = MatchModel.fromJson(json);

      // Act
      final jsonResult = match.toJson();

      // Assert
      expect(jsonResult['matchId'], '1');
      expect(jsonResult['creatorId'], 'creator456@example.com');
      expect(jsonResult['latitude'], 123.456);
      expect(jsonResult['longitude'], 45.012);
      expect(jsonResult['locationName'], 'Jakarta');
      
      // Ensure that teams are serialized as JSON correctly
      expect(jsonResult['teams'][0][0]['displayName'], 'Player A');
      expect(jsonResult['teams'][1][1]['displayName'], 'Player D');
      
      // Ensure team scores are serialized correctly
      expect(jsonResult['teamScores'][0][0], 2);
      expect(jsonResult['teamScores'][2][1], 3);
    });

  });
}
