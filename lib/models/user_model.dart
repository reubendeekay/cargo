import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final Timestamp? createdAt;
  final String? role;
  final String? branch;
  final File? imageFile;
  final String? profilePic;

  UserModel(
      {this.userId,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.password,
      this.createdAt,
      this.role,
      this.branch,
      this.imageFile,
      this.profilePic});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      userId: json.id,
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phone'],
      password: json['password'],
      createdAt: json['createdAt'],
      role: json['role'],
      branch: json['branch'],
      profilePic: json['profilePic'],
    );
  }
}
