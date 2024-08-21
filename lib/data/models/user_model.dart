import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String? displayName;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? photoUrl;
  @HiveField(3)
  final Timestamp? creationTime;

  //toJson and fromJson are required for Hive

  UserModel({
    this.displayName,
    this.email,
    this.photoUrl,
    this.creationTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json['displayName'] ?? 'N/A',
        email: json['email'] ?? 'N/A',
        photoUrl: json['photoUrl'],
        creationTime: json['creationTime'] ?? 'N/A',
      );

  Map<String, dynamic> toJson() => {
        'displayName': displayName ?? 'N/A',
        'email': email ?? 'N/A',
        'photoUrl': photoUrl,
        'creationTime': creationTime ?? 'N/A',
  };
}