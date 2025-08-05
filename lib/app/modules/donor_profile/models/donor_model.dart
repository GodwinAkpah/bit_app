class Donor {
  final String id;
  final String name;
  final String phone;
  final String location;
  final String bloodType;
  final String imageUrl;
  final int donated;
  final int requested;
  // final LatLng position; // REMOVED THIS LINE

  Donor({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.bloodType,
    required this.imageUrl,
    this.donated = 0,
    this.requested = 0,
    // required this.position, // REMOVED THIS LINE
  });
}