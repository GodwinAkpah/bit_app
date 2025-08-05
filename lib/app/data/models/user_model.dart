class UserModel {
  final String uid;
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
}