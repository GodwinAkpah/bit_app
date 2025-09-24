
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/services/core_service.dart';
import 'package:bit_app/services/user_service.dart';
import 'package:bit_app/services/models/user_model.dart';

class ProfileController extends GetxController {
  final UserService _userService;
  ProfileController(this._userService);

  final _coreService = Get.find<CoreService>();

  // Holds the user's profile data
  final user = Rx<UserModel?>(null);

  // --- UI State Management ---
  final isLoading = false.obs;
  final isEditMode = false.obs; // To toggle between view and edit modes

  // --- Form Controllers ---
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController genderController;
  late TextEditingController locationController;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
    _initializeControllers();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    genderController.dispose();
    locationController.dispose();
    super.onClose();
  }

  /// Loads user data from storage
  void _loadUserFromStorage() {
    final userData = _coreService.getStorage.read('user_data');
    if (userData != null) {
      user.value = UserModel.fromJson(userData);
    }
  }

  /// Initializes text controllers with user data
  void _initializeControllers() {
    usernameController = TextEditingController(text: user.value?.username ?? '');
    emailController = TextEditingController(text: user.value?.email ?? '');
    phoneController = TextEditingController(text: user.value?.phone ?? '');
    dobController = TextEditingController(text: user.value?.dateOfBirth ?? '');
    genderController = TextEditingController(text: user.value?.gender ?? '');
    locationController = TextEditingController(text: user.value?.location ?? '');
  }

  /// Toggles between profile view and edit mode
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    // If we are exiting edit mode without saving, reset controllers
    if (!isEditMode.value) {
      _initializeControllers();
    }
  }

  /// Toggles user's availability for donation
  void toggleAvailability(bool isAvailable) async {
    isLoading.value = true;
    try {
      final response = await _userService.updateProfile({'isAvailable': isAvailable});
      if (response.status == 'success' && response.data != null) {
        user.value = UserModel.fromJson(response.data!);
        Get.snackbar('Success', 'Availability updated successfully.', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', response.message, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Saves the updated profile information
  void saveProfile() async {
    isLoading.value = true;
    try {
      final updatedData = {
        'name': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'date_of_birth': dobController.text,
        'gender': genderController.text,
        'location': locationController.text,
      };

      final response = await _userService.updateProfile(updatedData);

      if (response.status == 'success' && response.data != null) {
        user.value = UserModel.fromJson(response.data!);
        isEditMode.value = false; // Exit edit mode on success
        Get.snackbar('Success', 'Profile updated successfully.', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', response.message, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Signs the user out
  void signOut() {
    _coreService.getStorage.remove('user_data');
    // Assuming you have a '/login' route defined in your app's routing
    Get.offAllNamed('/login'); 
  }
}
