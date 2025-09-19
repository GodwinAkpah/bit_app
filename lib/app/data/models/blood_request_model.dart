// class BloodRequestModel {
//   final String id;
//   final String name;
//   final String location;
//   final String bloodType;
//   final int unitsNeeded;
//   final String reason;
//   final String phone;

//   BloodRequestModel({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.bloodType,
//     required this.unitsNeeded,
//     required this.reason,
//     required this.phone,
//   });
// }
import 'dart:convert';

// Helper function
List<BloodRequestModel> bloodRequestModelFromJson(String str) => List<BloodRequestModel>.from(json.decode(str).map((x) => BloodRequestModel.fromJson(x)));

class BloodRequestModel {
    final int id;
    final int requesterId;
    final int? donorId; // Can be null if not yet accepted
    final String name;
    final String phone;
    final String bloodType;
    final double quantity; // API returns quantity as a double (e.g., 3.0)
    final String location;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;

    BloodRequestModel({
        required this.id,
        required this.requesterId,
        this.donorId,
        required this.name,
        required this.phone,
        required this.bloodType,
        required this.quantity,
        required this.location,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    // A getter to display the quantity cleanly
    String get unitsNeeded => '${quantity.toInt()} Units';

    factory BloodRequestModel.fromJson(Map<String, dynamic> json) => BloodRequestModel(
        id: json["id"],
        requesterId: json["requester_id"],
        donorId: json["donor_id"],
        name: json["name"] ?? 'N/A',
        phone: json["phone"] ?? 'N/A',
        bloodType: json["blood_type"] ?? 'N/A',
        quantity: json["quantity"]?.toDouble() ?? 0.0,
        location: json["location"] ?? 'N/A',
        status: json["status"] ?? 'Pending',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}