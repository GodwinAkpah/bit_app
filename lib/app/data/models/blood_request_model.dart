class BloodRequestModel {
  final String id;
  final String name;
  final String location;
  final String bloodType;
  final int unitsNeeded;
  final String reason;
  final String phone;

  BloodRequestModel({
    required this.id,
    required this.name,
    required this.location,
    required this.bloodType,
    required this.unitsNeeded,
    required this.reason,
    required this.phone,
  });
}