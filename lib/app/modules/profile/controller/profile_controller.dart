import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  // A reactive variable to hold the user's data. The UI will automatically
  // update whenever this changes.
  late Rx<UserModel> user;

  // A reactive flag to switch between viewing and editing the profile.
  final RxBool isEditMode = false.obs;
  
  // Text editing controllers for the 'Edit Profile' form.
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController genderController;
  late TextEditingController locationController;

  @override
  void onInit() {
    super.onInit();
    // In a real app, you would fetch user data from a database/API here.
    // For now, we load hardcoded mock data.
    _loadUserData();
  }

  /// Initializes the user object and the text editing controllers.
  void _loadUserData() {
    user = UserModel(
      uid: '123',
      username: 'Username',
      email: 'Username@Email.Com',
      phone: '08022834848',
      location: 'JOS, PLATEAU STATE',
      dateOfBirth: '20-11-1996',
      gender: 'Nil',
      bloodType: 'A+',
      donated: 5,
      requested: 2,
      isAvailable: true,
    ).obs;
    
    // Initialize text controllers with the user's current data.
    usernameController = TextEditingController(text: user.value.username);
    emailController = TextEditingController(text: user.value.email);
    phoneController = TextEditingController(text: user.value.phone);
    dobController = TextEditingController(text: user.value.dateOfBirth);
    genderController = TextEditingController(text: user.value.gender);
    locationController = TextEditingController(text: user.value.location);
  }

  /// Toggles the UI between the profile view and the edit form.
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  /// Updates the user's availability for donation.
  void toggleAvailability(bool value) {
    user.update((val) {
      val?.isAvailable = value;
    });
    // TODO: Add an API call here to persist this change.
  }

  /// Validates and saves the updated profile information.
  void saveProfile() {
    // TODO: Add form validation logic here.
    
    // TODO: Add an API call to save the data to your backend.
    print('Saving profile...');

    // Update the local reactive user model from the text controllers.
    // The UI will update automatically because `user` is an .obs variable.
    user.update((val) {
      val?.username = usernameController.text;
      val?.email = emailController.text;
      val?.phone = phoneController.text;
      val?.dateOfBirth = dobController.text;
      val?.gender = genderController.text;
      val?.location = locationController.text;
    });

    // Switch back to view mode after saving.
    toggleEditMode();
    Get.snackbar('Success', 'Profile updated successfully!', snackPosition: SnackPosition.BOTTOM);
  }

  /// Signs the user out and clears the navigation history.
  void signOut() {
    // TODO: Add logic here to clear any saved user session/token.
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  /// Dispose of controllers to prevent memory leaks when the screen is closed.
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    genderController.dispose();
    locationController.dispose();
    super.onClose();
  }
}