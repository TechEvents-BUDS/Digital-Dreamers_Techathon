// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  // final String? number;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    // required this.number,
  });

  toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      // number: data["number"],
    );
  }
}
