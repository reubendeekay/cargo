import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String? message;
  final String? category;
  final String? createdBy;
  final Timestamp? createdAt;

  NotificationModel(
      {this.id, this.message, this.createdAt, this.category, this.createdBy});

  factory NotificationModel.fromJson(DocumentSnapshot json) {
    return NotificationModel(
      id: json.id,
      message: json['message'],
      category: json['category'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'category': category,
      'createdBy': createdBy,
    };
  }
}
