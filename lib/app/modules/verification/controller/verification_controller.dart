import 'dart:async';
import 'package:flutter/material.dart'; // Import for Get.snackbar
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart'; // For snackbar colors

class VerificationController extends GetxController {
  late String phoneNumber;
  final RxBool isOtpSent = false.obs;
  final RxInt resendTimer = 30.obs;
  Timer? _timer;

  // --- DEVELOPMENT ONLY: Define the "correct" OTP ---
  final String _correctOtp = "1234";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      phoneNumber = Get.arguments as String;
    } else {
      phoneNumber = "Number not found";
    }
  }

  void sendOtp() {
    print('SIMULATING: Sending OTP to $phoneNumber');
    isOtpSent.value = true;
    startResendTimer();

    // Show a snackbar to the developer/tester with the correct OTP
    Get.snackbar(
      'Development OTP',
      'The OTP code is: $_correctOtp',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Called when the OTP is entered (e.g., from the Pinput widget)
  void verifyOtp(String otp) {
    print('Verifying entered OTP: $otp');

    // --- SIMULATED VERIFICATION LOGIC ---
    if (otp == _correctOtp) {
      print('SUCCESS: OTP is correct.');

      // Show a success message
      Get.snackbar(
        'Success!',
        'Phone number verified successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryTeal,
        colorText: Colors.white,
      );

      // If verification is successful, navigate to the next step
      // Use a small delay to allow the user to see the success message
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(AppRoutes.ON_BOARDING);
      });
      
    } else {
      print('ERROR: Incorrect OTP.');
      // Show an error message
      Get.snackbar(
        'Verification Failed',
        'The entered OTP is incorrect. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
      );
    }
  }

  void resendOtp() {
    if (resendTimer.value == 0) {
      print('SIMULATING: Resending OTP to $phoneNumber');
      resendTimer.value = 30; // Reset timer
      startResendTimer();

      // Show the developer the OTP again
      Get.snackbar(
        'Development OTP',
        'The OTP code is: $_correctOtp',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get maskedPhoneNumber {
    if (phoneNumber.length > 4) {
      return '+234 *** *** ${phoneNumber.substring(phoneNumber.length - 3)}';
    }
    return phoneNumber;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}