import 'dart:io';


class BranchModel {
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? email;
   String? imageUrl;
  final String? id;
  final File? imageFile;
  final String? managerId;
  final String? managerName;

  BranchModel(
      {this.name,
      this.address,
      this.phoneNumber,
      this.email,
      this.imageUrl,
      this.imageFile,
      this.id,
      this.managerId,
      this.managerName});

  factory BranchModel.fromJson(dynamic json) {
    return BranchModel(
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      id: json.id,
      managerId: json['managerId'],
      managerName: json['managerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'imageUrl': imageUrl,
      'managerId': managerId,
      'managerName': managerName,
    };
  }
}
