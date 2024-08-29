import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'timeline_item_model.g.dart';

@HiveType(typeId: 4)
class TimelineItemModel extends HiveObject {
  @HiveField(0)
  final String? timelineItemId;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? type;
  @HiveField(3)
  final Timestamp? timestamp;

  TimelineItemModel({this.timelineItemId, this.title, this.type, this.timestamp});

  factory TimelineItemModel.fromJson(Map<String, dynamic> json) {
    return TimelineItemModel(
      timelineItemId: json['timelineItemId'],
      title: json['title'],
      type: json['type'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timelineItemId': timelineItemId,
      'title': title,
      'type': type,
      'timestamp': timestamp,
    };
  }
  
}