
// import 'dart:convert';

// List<BloodRequestModel> bloodRequestModelFromJson(String str) => List<BloodRequestModel>.from(json.decode(str).map((x) => BloodRequestModel.fromJson(x)));

// class BloodRequestModel {
//     final int id;
//     final int requesterId;
//     final int? donorId;
//     final String name;
//     final String phone;
//     final String bloodType;
//     final double quantity;
//     final String location;
//     final String status;
//     // --- THE FIX IS HERE ---
//     final String? reason; // 1. Add the nullable 'reason' property.
//     // --- END FIX ---
//     final DateTime createdAt;
//     final DateTime updatedAt;

//     BloodRequestModel({
//         required this.id,
//         required this.requesterId,
//         this.donorId,
//         required this.name,
//         required this.phone,
//         required this.bloodType,
//         required this.quantity,
//         required this.location,
//         required this.status,
//         this.reason, // 2. Add it to the constructor.
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     String get unitsNeeded => '${quantity.toInt()} Units';

//     factory BloodRequestModel.fromJson(Map<String, dynamic> json) => BloodRequestModel(
//         id: json["id"],
//         requesterId: json["requester_id"],
//         donorId: json["donor_id"],
//         name: json["name"] ?? 'N/A',
//         phone: json["phone"] ?? 'N/A',
//         bloodType: json["blood_type"] ?? 'N/A',
//         quantity: json["quantity"]?.toDouble() ?? 0.0,
//         location: json["location"] ?? 'N/A',
//         status: json["status"] ?? 'Pending',
//         reason: json["reason"], // 3. Parse it from the JSON.
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );
// }
import 'dart:convert';

List<BloodRequestModel> bloodRequestModelFromJson(String str) => List<BloodRequestModel>.from(json.decode(str).map((x) => BloodRequestModel.fromJson(x)));

class BloodRequestModel {
    final int id;
    final int requesterId;
    final int? donorId;
    final String name;
    final String phone;
    final String bloodType;
    final double quantity;
    final String location;
    final String status;
    final String? reason; // This is nullable
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
        this.reason,
        required this.createdAt,
        required this.updatedAt,
    });

    String get unitsNeeded => '${quantity.toInt()} Units';

    // --- THIS IS THE FINAL, CORRECTED CONSTRUCTOR ---
    factory BloodRequestModel.fromJson(Map<String, dynamic> json) {
      return BloodRequestModel(
        id: json["id"] ?? 0,
        requesterId: json["requester_id"] ?? 0,
        donorId: json["donor_id"],
        name: json["name"] ?? 'N/A',
        phone: json["phone"]?.toString() ?? 'N/A', // Safely convert to string
        bloodType: json["blood_type"] ?? 'N/A',
        quantity: (json["quantity"] ?? 0.0).toDouble(),
        location: json["location"] ?? 'N/A',
        status: json["status"] ?? 'Pending',
        // Check if the key exists before trying to access it
        reason: json.containsKey('reason') ? json["reason"] : null,
        createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
      );
    }
}