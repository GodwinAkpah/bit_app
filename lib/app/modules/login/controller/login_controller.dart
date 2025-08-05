import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Controllers for the text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive variable to toggle password visibility
  final RxBool isPasswordVisible = false.obs;

  /// Toggles the visibility of the password text.
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Handles the main login button press.
  void loginUser() {
    // TODO: Add form validation and real authentication logic here.
    print('Attempting to log in with Email: ${emailController.text}');
    
    // On success, navigate to the Home screen
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  /// Placeholder function for biometric login taps. Does nothing.
  void onBiometricLoginTap() {
    print("Biometric login tapped, but not implemented.");
    // In a real app, this would trigger the local_auth flow.
    Get.snackbar(
      'Feature Not Implemented', 
      'Biometric login is for UI demonstration only.',
      snackPosition: SnackPosition.BOTTOM
    );
  }

  /// Placeholder function for social login taps. Does nothing.
  void onSocialLoginTap(String provider) {
    print("$provider login tapped, but not implemented.");
     Get.snackbar(
      'Feature Not Implemented', 
      '$provider login is for UI demonstration only.',
      snackPosition: SnackPosition.BOTTOM
    );
  }

  /// Cleans up controllers to prevent memory leaks.
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}