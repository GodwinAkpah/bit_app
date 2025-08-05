import 'package:bit_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  // Text Editing Controllers for form fields
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Reactive variables for UI state changes
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool termsAccepted = false.obs;
  final RxString selectedBloodGroup = ''.obs;

  // Static list of available blood groups
  final List<String> bloodGroups = const [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  /// Toggles the visibility of the password field.
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggles the visibility of the confirm password field.
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Updates the selected blood group from the UI.
  void selectBloodGroup(String group) {
    selectedBloodGroup.value = group;
  }

  /// Validates the form and attempts to register the user.
  void registerUser() {
    // --- Form Validation Logic ---
    if (fullNameController.text.trim().isEmpty) {
      _showError('Please enter your full name.');
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError('Please enter your phone number.');
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      _showError('Please enter a valid email address.');
      return;
    }
    if (selectedBloodGroup.value.isEmpty) {
      _showError('Please select your blood group.');
      return;
    }
    if (passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters long.');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match.');
      return;
    }
    if (!termsAccepted.value) {
      _showError('You must accept the Terms and Conditions.');
      return;
    }

    // --- If Validation Passes ---
    print('Validation successful. Proceeding to registration...');
    print('Full Name: ${fullNameController.text}');
    print('Phone: ${phoneController.text}');
    print('Email: ${emailController.text}');
    print('Blood Group: ${selectedBloodGroup.value}');
    print('Terms Accepted: ${termsAccepted.value}');

    // TODO: Add the actual API call to your backend here to register the user.

    // Navigate to the Verification screen, passing the phone number as an argument.
    String phoneNumber = phoneController.text.trim();
    Get.toNamed(AppRoutes.VERIFICATION, arguments: phoneNumber);
  }

  /// Helper method to show a standardized error snackbar.
  void _showError(String message) {
    Get.snackbar(
      'Registration Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }

  /// Cleans up the controllers when the screen is closed to prevent memory leaks.
  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}