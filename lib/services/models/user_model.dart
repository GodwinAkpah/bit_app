import 'package:flutter/foundation.dart';

class UserModel {
  String uid;
  String username;
  String email;
  String phone;
  String location;
  String dateOfBirth;
  String gender;
  String bloodType;
  int donated;
  int requested;
  bool isAvailable;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.location,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodType,
    this.donated = 0,
    this.requested = 0,
    this.isAvailable = true,
  });

  // Factory constructor to create a UserModel from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'].toString(),
      username: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? "08012345678",
      location: json['location'] ?? 'N/A',
      gender: json['gender'] ?? 'N/A',
      bloodType: json['blood_type'] ?? 'N/A',
      donated: json['donations'] ?? 0,
      requested: json['requests'] ?? 0,
      dateOfBirth: json['date_of_birth'] ?? '',
    );
  }

  // Method to convert a UserModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': username,
      'email': email,
      'phone': phone,
      'location': location,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'blood_type': bloodType,
      'donations': donated,
      'requests': requested,
    };
  }
}
