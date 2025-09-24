class BloodRequestModel {
  final String id;
  final String bloodType;
  final int quantity;
  final String location;
  final String requesterId;
  final String name;
  final String phone;
  final String? reason;
  final String status;
  final DateTime createdAt;

  BloodRequestModel({
    required this.id,
    required this.bloodType,
    required this.quantity,
    required this.location,
    required this.requesterId,
    required this.name,
    required this.phone,
    this.reason,
    required this.status,
    required this.createdAt,
  });

  factory BloodRequestModel.fromJson(Map<String, dynamic> json) {
    return BloodRequestModel(
      id: json['id'].toString(),
      bloodType: json['blood_type'] as String,
      quantity: json['quantity'] as int,
      location: json['location'] as String,
      requesterId: json['requester_id'].toString(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      reason: json['reason'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
