import 'package:bit_app/app/modules/donor_profile/models/donor_model.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:get/get.dart';



class FindDonorController extends GetxController {
  // A hardcoded list for demonstration. In a real app, this comes from an API.
  final List<Donor> _allDonors = [
    Donor(id: '1', name: 'Vanessa Franklin', phone: '09069987764', location: 'LAMINGO, PLATEAU STATE', bloodType: 'A+', imageUrl: 'assets/images/donor1.png', donated: 8, requested: 3),
    Donor(id: '2', name: 'Ephraim Brony', phone: '09069987764', location: 'LAMINGO, PLATEAU STATE', bloodType: 'B+', imageUrl: 'assets/images/donor2.png', donated: 5),
    Donor(id: '3', name: 'Jon Franklin', phone: '09069987764', location: 'RAYFIELD, PLATEAU STATE', bloodType: 'AB+', imageUrl: 'assets/images/donor3.png', donated: 12, requested: 1),
    Donor(id: '4', name: 'Rose Park', phone: '09069987764', location: 'TUDUN WADA, PLATEAU STATE', bloodType: 'O+', imageUrl: 'assets/images/donor4.png', requested: 5),
  ];

  // A reactive list that the UI will listen to for changes.
  final RxList<Donor> filteredDonors = <Donor>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the list with all donors when the screen loads.
    filteredDonors.assignAll(_allDonors);
  }

  /// Filters the donor list based on a search query.
  void search(String query) {
    if (query.isEmpty) {
      filteredDonors.assignAll(_allDonors);
    } else {
      // Filter by name or blood type, case-insensitively.
      final lowerCaseQuery = query.toLowerCase();
      filteredDonors.value = _allDonors
          .where((donor) =>
              donor.name.toLowerCase().contains(lowerCaseQuery) ||
              donor.bloodType.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }
  }
  
  /// Navigates to the profile screen, passing the selected donor object.
  void navigateToDonorProfile(Donor donor) {
    Get.toNamed(AppRoutes.DONOR_PROFILE, arguments: donor);
  }
}