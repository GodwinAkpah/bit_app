import 'package:bit_app/app/data/models/user_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorProfileController extends GetxController {
  late UserModel user; // THE FIX: Changed from Donor to UserModel

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments as UserModel; // THE FIX: Changed from Donor to UserModel
  }

  Future<void> callDonor() async {
    // THE FIX: Use the 'user' object to get the phone number
    final Uri phoneCallUri = Uri(scheme: 'tel', path: user.phone);
    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      Get.snackbar('Action Failed', 'Could not make a phone call to ${user.phone}.');
    }
  }

  void requestBlood() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: AppColors.primaryRed, size: 50),
              const SizedBox(height: 16),
              const Text('Request Sent!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Your request has been sent. Make sure to contact donor by clicking the call button.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () => Get.back());
  }
}
