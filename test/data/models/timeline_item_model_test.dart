import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';

void main() {
  group('TimelineItemModel', () {
    test('should create a TimelineItemModel instance with all fields', () {
      final timestamp = Timestamp.now();
      final model = TimelineItemModel(
        timelineItemId: '123',
        title: 'Test Title',
        type: 'Test Type',
        timestamp: timestamp,
      );

      expect(model.timelineItemId, '123');
      expect(model.title, 'Test Title');
      expect(model.type, 'Test Type');
      expect(model.timestamp, timestamp);
    });

    test('should create a TimelineItemModel from JSON', () {
      final timestamp = Timestamp.now();
      final json = {
        'timelineItemId': '456',
        'title': 'JSON Title',
        'type': 'JSON Type',
        'timestamp': timestamp,
      };

      final model = TimelineItemModel.fromJson(json);

      expect(model.timelineItemId, '456');
      expect(model.title, 'JSON Title');
      expect(model.type, 'JSON Type');
      expect(model.timestamp, timestamp);
    });

    test('should convert TimelineItemModel to JSON', () {
      final timestamp = Timestamp.now();
      final model = TimelineItemModel(
        timelineItemId: '789',
        title: 'To JSON Title',
        type: 'To JSON Type',
        timestamp: timestamp,
      );

      final json = model.toJson();

      expect(json['timelineItemId'], '789');
      expect(json['title'], 'To JSON Title');
      expect(json['type'], 'To JSON Type');
      expect(json['timestamp'], timestamp);
    });

    test('should handle null values in fromJson', () {
      final json = {
        'timelineItemId': null,
        'title': null,
        'type': null,
        'timestamp': null,
      };

      final model = TimelineItemModel.fromJson(json);

      expect(model.timelineItemId, null);
      expect(model.title, null);
      expect(model.type, null);
      expect(model.timestamp, null);
    });

    test('should handle null values in toJson', () {
      final model = TimelineItemModel();

      final json = model.toJson();

      expect(json['timelineItemId'], null);
      expect(json['title'], null);
      expect(json['type'], null);
      expect(json['timestamp'], null);
    });
  });
}
