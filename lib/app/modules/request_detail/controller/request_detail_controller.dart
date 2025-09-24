import 'package:bit_app/app/data/models/blood_request_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailController extends GetxController {
  // --- DEPENDENCIES ---
  final RequestService _requestService = Get.find<RequestService>();
  final _storage = GetStorage();

  // --- UI STATE ---
  final Rx<BloodRequestModel> request = Rx<BloodRequestModel>(
    BloodRequestModel(id: '', requesterId: '', name: '', phone: '', bloodType: '', quantity: 0, location: '', status: '', createdAt: DateTime.now())
  );
  final RxBool isLoadingPage = false.obs; // Initially false, since we have data
  final RxBool isAccepting = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Directly get the data passed from the previous screen.
    // No need to re-fetch what we already have.
    final initialRequest = Get.arguments as BloodRequestModel?;

    if (initialRequest != null) {
      request.value = initialRequest;
    } else {
      // If for some reason no data is passed, show an error.
      errorMessage.value = "No request details found.";
    }
  }

  // This method is kept for cases where a refresh might be needed,
  // for example, after accepting a request.
  Future<void> fetchRequestDetails(String requestId) async {
    try {
      errorMessage.value = '';
      final response = await _requestService.getBloodRequestById(requestId);
      
      if (response.status == 'success' && response.data != null) {
        request.value = BloodRequestModel.fromJson(response.data);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e, stackTrace) {
      print("----------- PARSING EXCEPTION CAUGHT in RequestDetailController -----------");
      print("Error: $e");
      print("StackTrace: $stackTrace");
      print("-----------------------------------------------------------------------");
      errorMessage.value = "An unexpected error occurred while processing data.";
    }
  }

  Future<void> callNow() async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: request.value.phone);
    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      Get.snackbar('Action Failed', 'Could not place a call to ${request.value.phone}.');
    }
  }

  void acceptRequest() async {
    final userDataMap = _storage.read('user_data');
    if (userDataMap == null) {
      Get.snackbar('Error', 'Could not identify the current user. Please log in again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    final currentUser = UserModel.fromJson(userDataMap);
    final donorId = currentUser.uid;

    isAccepting.value = true;
    try {
      final Map<String, dynamic> updateData = {
        "donor_id": donorId,
        "status": "Accepted",
      };

      final response = await _requestService.acceptBloodRequest(
        requestId: request.value.id,
        data: updateData,
      );

      if (response.status == 'success') {
        _showSuccessDialog();
        // Refresh the data to show the updated status.
        fetchRequestDetails(request.value.id);
      } else {
        Get.snackbar('Failed', response.message, backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isAccepting.value = false;
    }
  }

  void _showSuccessDialog() {
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
    Future.delayed(const Duration(seconds: 3), () => Get.back());
  }
}
