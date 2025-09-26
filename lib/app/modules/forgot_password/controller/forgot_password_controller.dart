import 'package:bit_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();

  void sendPasswordResetEmail() async {
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Please enter a valid email.');
      return;
    }

    try {
      final response = await _authService.forgotPassword(emailController.text.trim());
      if (response.status == 'success') {
        Get.snackbar('Success', 'Password reset email sent. Please check your inbox.');
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
