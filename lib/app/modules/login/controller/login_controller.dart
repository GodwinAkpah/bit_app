import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // --- DEPENDENCIES ---
  final AuthService _authService = Get.find<AuthService>();
  final _storage = GetStorage();

  // --- FORM CONTROLLERS ---
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // --- UI STATE ---
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  // --- UI LOGIC ---
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  /// Main function to validate, log in, and save user session.
  void loginUser() async {
    if (!_validateForm()) return;

    isLoading.value = true;

    try {
      final Map<String, dynamic> loginData = {
        "email": emailController.text.trim(),
        "password": passwordController.text,
      };

      final response = await _authService.login(loginData);

      if (response.status == 'success') {
        final token = response.data?['access_token'];
        final userDataMap = response.data?['user'];

        if (token != null && token is String && userDataMap != null && userDataMap is Map<String, dynamic>) {
          await _storage.write('auth_token', token);

          final user = UserModel(
            uid: userDataMap['id'].toString(),
            username: userDataMap['name'] ?? 'N/A',
            email: userDataMap['email'] ?? 'N/A',
            phone: userDataMap['phone'] ?? "08012345678",
            location: userDataMap['location'] ?? 'N/A',
            gender: userDataMap['gender'] ?? 'N/A',
            bloodType: userDataMap['blood_type'] ?? 'N/A',
            donated: userDataMap['donations'] ?? 0,
            requested: userDataMap['requests'] ?? 0,
            dateOfBirth: userDataMap['date_of_birth'] ?? '',
          );

          await _storage.write('user_data', user.toJson());
          
          _showSnackbar('Success', 'Login successful!', isError: false);
          Get.offAllNamed(AppRoutes.DASHBOARD);
        } else {
          _showSnackbar('Login Error', 'Authentication failed: Invalid response from server.', isError: true);
        }
      } else {
        _showSnackbar('Login Failed', response.message, isError: true);
      }
    } catch (e) {
      print("Login Controller Error: $e");
      _showSnackbar('Error', 'An unexpected error occurred. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // --- HELPER & PLACEHOLDER METHODS ---
  bool _validateForm() {
    if (!GetUtils.isEmail(emailController.text.trim())) { _showSnackbar('Login Error', 'Please enter a valid email.', isError: true); return false; }
    if (passwordController.text.isEmpty) { _showSnackbar('Login Error', 'Please enter your password.', isError:true); return false; }
    return true;
  }

  void _showSnackbar(String title, String message, {required bool isError}) {
    Get.snackbar( title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: isError ? Colors.redAccent : Colors.green, colorText: Colors.white, margin: const EdgeInsets.all(10));
  }

  void onBiometricLoginTap() => _showSnackbar('Info', 'Biometric login is not yet implemented.', isError: false);
  void onSocialLoginTap(String provider) => _showSnackbar('Info', '$provider login is not yet implemented.', isError: false);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
