import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/blood_request_model.dart';
import '../../../utils/app_colors.dart';

class RequestDetailController extends GetxController {
  late BloodRequestModel request;

  @override
  void onInit() {
    super.onInit();
    request = Get.arguments as BloodRequestModel;
  }

  Future<void> callNow() async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: request.phone);
    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      Get.snackbar('Action Failed', 'Could not place a call to ${request.phone}.');
    }
  }

  void acceptRequest() {
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
              const Text('Request Accepted!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Contact this user by clicking the call button',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );

    // After 3 seconds, close the dialog
    Future.delayed(const Duration(seconds: 3), () => Get.back());
  }
}