
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/user_service.dart';

class FindDonorController extends GetxController {
  final UserService _userService;
  FindDonorController(this._userService);

  // --- State Management ---
  final RxList<UserModel> allDonors = <UserModel>[].obs;       // Holds all donors fetched from the API
  final RxList<UserModel> filteredDonors = <UserModel>[].obs; // The list displayed on the screen
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  // --- Search and Filter ---
  final TextEditingController searchController = TextEditingController();

  // A clear and user-friendly list for the blood group filter UI
  final List<String> bloodGroups = ['All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final RxString selectedBloodGroup = 'All'.obs; // Default to show all blood groups

  @override
  void onInit() {
    super.onInit();
    fetchAllDonors();

    // Add listeners to automatically trigger the filter when the user types or selects a new group
    searchController.addListener(_filterDonors);
    selectedBloodGroup.listen((_) => _filterDonors());
  }

  @override
  void onClose() {
    searchController.removeListener(_filterDonors);
    searchController.dispose();
    super.onClose();
  }

  /// Fetches the initial list of all available donors from the UserService.
  Future<void> fetchAllDonors() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Using the correct service we built earlier.
      final response = await _userService.findDonors();

      if (response.status == 'success' && response.data != null) {
        final List<dynamic> donorData = response.data as List<dynamic>;
        // Parsing the raw JSON data into our standard UserModel.
        final donors = donorData.map((data) => UserModel.fromJson(data)).toList();
        
        allDonors.assignAll(donors);
        filteredDonors.assignAll(donors); // Initially, the filtered list is the full list
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      print("Fetch Donors Error: $e");
      errorMessage.value = 'An unexpected error occurred while fetching donors.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Filters the list of donors based on the search query and selected blood group.
  void _filterDonors() {
    final nameQuery = searchController.text.toLowerCase();
    final bloodGroupQuery = selectedBloodGroup.value;

    List<UserModel> tempFilteredList = allDonors.where((donor) {
      // Using the properties from our UserModel.
      final donorName = donor.username.toLowerCase();
      final donorBloodType = donor.bloodType;

      final nameMatches = nameQuery.isEmpty || donorName.contains(nameQuery);
      final bloodGroupMatches = bloodGroupQuery == 'All' || donorBloodType == bloodGroupQuery;

      return nameMatches && bloodGroupMatches;
    }).toList();

    filteredDonors.assignAll(tempFilteredList);
  }

  /// Navigates to a specific donor's profile. (Assumes a route is set up)
  void navigateToDonorProfile(UserModel donor) {
    // We can pass the whole user model to the next screen
    // Get.toNamed(AppRoutes.DONOR_PROFILE, arguments: donor);
    Get.snackbar('Navigate', 'Tapped on ${donor.username}'); // Placeholder action
  }
}
