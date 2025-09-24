class UserModel {
  final String id;
  final String fullName;
  final String bloodGroup;
  final String phone;
  final String location;

  UserModel({
    required this.id,
    required this.fullName,
    required this.bloodGroup,
    required this.phone,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location']?['name'] ?? '', // Safely access nested location name
    );
  }
}
