
// import 'package:bit_app/app/routes/app_routes.dart';
// import 'package:bit_app/services/auth/auth_service.dart';
// import 'package:bit_app/services/service_manifest.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart'; // Import for DioException type

// class SignUpController extends GetxController {
//   // --- DEPENDENCY INJECTION ---
//   final AuthService _authService = serviceLocator<AuthService>();

//   // --- FORM CONTROLLERS ---
//   final fullNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final locationController = TextEditingController();
//   final genderController = TextEditingController();

//   // --- UI STATE MANAGEMENT ---
//   final RxBool isPasswordVisible = false.obs;
//   final RxBool isConfirmPasswordVisible = false.obs;
//   final RxBool termsAccepted = false.obs;
//   final RxString selectedBloodGroup = ''.obs;
//   final RxBool isLoading = false.obs;
//   final RxString selectedGender = ''.obs;

//   // --- STATIC DATA ---
//   final List<String> bloodGroups = const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
//   final List<String> genders = const ['Male', 'Female'];

//   // --- UI LOGIC ---
//   void togglePasswordVisibility() => isPasswordVisible.toggle();
//   void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();
//   void selectBloodGroup(String group) => selectedBloodGroup.value = group;
//   void selectGender(String gender) {
//     selectedGender.value = gender;
//     genderController.text = gender;
//   }

//   /// Main function to validate and register the user via API.
//   void registerUser() async {
//     if (!_validateForm()) return;
//     isLoading.value = true;

//     try {
//       final Map<String, dynamic> registrationData = {
//         "email": emailController.text.trim(),
//         "password": passwordController.text,
//         "name": fullNameController.text.trim(),
//         "blood_type": selectedBloodGroup.value,
//         "location": locationController.text.trim(),
//         "gender": selectedGender.value.toLowerCase(),
//       };

//       // Call the authentication service
//       final response = await _authService.register(registrationData);

//       // --- ENHANCED DEBUGGING PRINT STATEMENT ---
//       // This will show us exactly how our APIResponse model interpreted the server's data.
//       print("--- RAW DATA PARSED BY APIRESPONSE MODEL ---");
//       print("Status Key Found: ${response.status}");
//       print("Message Key Found: ${response.message}");
//       print("Data Body: ${response.data}");
//       print("------------------------------------------");

//       // Check the parsed response status
//       if (response.status == 'success') {
//         _showSnackbar('Success', response.message, isError: false);
//         Get.toNamed(AppRoutes.VERIFICATION, arguments: emailController.text.trim());
//       } else {
//         _showSnackbar('Registration Failed', response.message, isError: true);
//       }
//     } on DioException catch (e) {
//       // This block handles specific network-level errors (e.g., 4xx, 5xx, timeout)
//       print("----------- DIO EXCEPTION CAUGHT -----------");
//       print("Status Code: ${e.response?.statusCode}");
//       print("Response Data: ${e.response?.data}");
//       print("------------------------------------------");
//       final serverMessage = e.response?.data?['msg'] ?? 'A network error occurred.';
//       _showSnackbar('Error', serverMessage, isError: true);
//     } catch (e, stackTrace) {
//       // This block catches any other unexpected errors (e.g., a model parsing error)
//       print("----------- UNKNOWN EXCEPTION CAUGHT -----------");
//       print("Error: $e");
//       print("StackTrace: $stackTrace");
//       print("---------------------------------------------");
//       _showSnackbar('Application Error', 'An unexpected error occurred.', isError: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // --- HELPER METHODS ---
//   bool _validateForm() {
//     if (fullNameController.text.trim().isEmpty) { _showSnackbar('Validation Error', 'Please enter your full name.', isError: true); return false; }
//     if (!GetUtils.isEmail(emailController.text.trim())) { _showSnackbar('Validation Error', 'Please enter a valid email address.', isError: true); return false; }
//     if (selectedBloodGroup.value.isEmpty) { _showSnackbar('Validation Error', 'Please select your blood group.', isError: true); return false; }
//     if (locationController.text.trim().isEmpty) { _showSnackbar('Validation Error', 'Please enter your location.', isError: true); return false; }
//     if (selectedGender.value.isEmpty) { _showSnackbar('Validation Error', 'Please select your gender.', isError: true); return false; }
//     if (passwordController.text.length < 6) { _showSnackbar('Validation Error', 'Password must be at least 6 characters.', isError: true); return false; }
//     if (passwordController.text != confirmPasswordController.text) { _showSnackbar('Validation Error', 'Passwords do not match.', isError: true); return false; }
//     if (!termsAccepted.value) { _showSnackbar('Validation Error', 'You must accept the Terms and Conditions.', isError: true); return false; }
//     return true;
//   }

//   void _showSnackbar(String title, String message, {required bool isError}) {
//     Get.snackbar(
//       title, message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? Colors.redAccent : Colors.green,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(10),
//     );
//   }

//   @override
//   void onClose() {
//     fullNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     locationController.dispose();
//     genderController.dispose();
//     super.onClose();
//   }
// }

import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthService _authService = serviceLocator<AuthService>();

  // All form controllers and state variables...
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final locationController = TextEditingController();
  final genderController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool termsAccepted = false.obs;
  final RxString selectedBloodGroup = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString selectedGender = ''.obs;
  final List<String> bloodGroups = const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> genders = const ['Male', 'Female'];

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();
  void selectBloodGroup(String group) => selectedBloodGroup.value = group;
  void selectGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  void registerUser() async {
    if (!_validateForm()) return;
    isLoading.value = true;

    try {
      final Map<String, dynamic> registrationData = {
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "name": fullNameController.text.trim(),
        "blood_type": selectedBloodGroup.value,
        "location": locationController.text.trim(),
        "gender": selectedGender.value.toLowerCase(),
      };

      final response = await _authService.register(registrationData);

      // Now, because of our CoreService fix, response.status will be 'success'
      if (response.status == 'success') {
        // The message will be the generic "Operation successful" from the CoreService
        _showSnackbar('Success', 'Registration completed successfully!', isError: false);
       Get.offNamed(AppRoutes.VERIFICATION, arguments: emailController.text.trim());
      } else {
        _showSnackbar('Registration Failed', response.message, isError: true);
      }
    } catch (e) {
      _showSnackbar('Error', 'An unexpected error occurred. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // --- Helper methods ---
  bool _validateForm() { /* ... */ return true; }
  void _showSnackbar(String title, String message, {required bool isError}) { /* ... */ }
  @override
  void onClose() { /* ... */ }
}