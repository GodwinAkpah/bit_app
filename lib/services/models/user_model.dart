// import 'dart:convert';

// // This helper function is optional but good to have.
// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   final String uid;
//   final String username;
//   final String email;
//   final String phone;
//   final String location;
//   final String dateOfBirth;
//   final String gender;
//   final String bloodType;
//   final int donated;
//   final int requested;
//   final bool isAvailable;

//   UserModel({
//     required this.uid,
//     required this.username,
//     required this.email,
//     required this.phone,
//     required this.location,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.bloodType,
//     this.donated = 0,
//     this.requested = 0,
//     this.isAvailable = true,
//   });

//   /// The method to create a UserModel from a Map (like from GetStorage).
//   /// The error on `.fromJson` will be fixed by this.
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       uid: json['uid'] ?? '',
//       username: json['username'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '',
//       location: json['location'] ?? '',
//       dateOfBirth: json['dateOfBirth'] ?? '',
//       gender: json['gender'] ?? '',
//       bloodType: json['bloodType'] ?? '',
//       donated: json['donated'] ?? 0,
//       requested: json['requested'] ?? 0,
//       isAvailable: json['isAvailable'] ?? true,
//     );
//   }

//   /// The method to convert a UserModel to a Map.
//   /// The error on `.toJson` will be fixed by this.
//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'username': username,
//       'email': email,
//       'phone': phone,
//       'location': location,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'bloodType': bloodType,
//       'donated': donated,
//       'requested': requested,
//       'isAvailable': isAvailable,
//     };
//   }
// }
import 'dart:convert';

class UserModel {
  // THE FIX: 'uid' can remain final as it's a unique identifier.
  final String uid; 

  // THE FIX: Removed 'final' from all properties that can be edited.
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? '',
      username: json["username"] ?? '',
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
      location: json["location"] ?? '',
      dateOfBirth: json["dateOfBirth"] ?? '',
      gender: json["gender"] ?? '',
      bloodType: json["bloodType"] ?? '',
      donated: json["donated"] ?? 0,
      requested: json["requested"] ?? 0,
      isAvailable: json["isAvailable"] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "phone": phone,
      "location": location,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "bloodType": bloodType,
      "donated": donated,
      "requested": requested,
      "isAvailable": isAvailable,
    };
  }
}