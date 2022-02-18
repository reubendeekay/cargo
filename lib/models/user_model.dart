import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final Timestamp? createdAt;

  UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.password,
    this.createdAt,
  });
}
