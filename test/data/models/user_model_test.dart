import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';

void main() {
  group('UserModel toJson', () {
    test('toJson with all fields populated', () {
      final user = UserModel(
        displayName: 'John Doe',
        email: 'john@example.com',
        photoUrl: 'https://example.com/photo.jpg',
        creationTime: Timestamp.fromDate(DateTime(2023, 1, 1)),
        lastLogin: Timestamp.fromDate(DateTime(2023, 2, 1)),
      );

      final json = user.toJson();

      expect(json['displayName'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');
      expect(json['creationTime'], isA<Timestamp>());
      expect(json['lastLogin'], isA<Timestamp>());
    });

    test('toJson with null displayName and email', () {
      final user = UserModel(
        photoUrl: 'https://example.com/photo.jpg',
        creationTime: Timestamp.fromDate(DateTime(2023, 1, 1)),
      );

      final json = user.toJson();

      expect(json['displayName'], 'N/A');
      expect(json['email'], 'N/A');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');
      expect(json['creationTime'], isA<Timestamp>());
      expect(json['lastLogin'], isA<Timestamp>());
    });

    test('toJson with null photoUrl', () {
      final user = UserModel(
        displayName: 'Jane Doe',
        email: 'jane@example.com',
        creationTime: Timestamp.fromDate(DateTime(2023, 1, 1)),
      );

      final json = user.toJson();

      expect(json['displayName'], 'Jane Doe');
      expect(json['email'], 'jane@example.com');
      expect(json['photoUrl'], isNull);
      expect(json['creationTime'], isA<Timestamp>());
      expect(json['lastLogin'], isA<Timestamp>());
    });

    test('toJson with null lastLogin', () {
      final user = UserModel(
        displayName: 'Bob Smith',
        email: 'bob@example.com',
        photoUrl: 'https://example.com/bob.jpg',
        creationTime: Timestamp.fromDate(DateTime(2023, 1, 1)),
      );

      final json = user.toJson();

      expect(json['displayName'], 'Bob Smith');
      expect(json['email'], 'bob@example.com');
      expect(json['photoUrl'], 'https://example.com/bob.jpg');
      expect(json['creationTime'], isA<Timestamp>());
      expect(json['lastLogin'], isA<Timestamp>());
    });

    test('toJson with empty statistics', () {
      final user = UserModel(
        displayName: 'Alice Johnson',
        email: 'alice@example.com',
        photoUrl: 'https://example.com/alice.jpg',
        creationTime: Timestamp.fromDate(DateTime(2023, 1, 1)),
        lastLogin: Timestamp.fromDate(DateTime(2023, 2, 1)),
      );

      final json = user.toJson();

      expect(json['displayName'], 'Alice Johnson');
      expect(json['email'], 'alice@example.com');
      expect(json['photoUrl'], 'https://example.com/alice.jpg');
      expect(json['creationTime'], isA<Timestamp>());
      expect(json['lastLogin'], isA<Timestamp>());
    });
  });
}
