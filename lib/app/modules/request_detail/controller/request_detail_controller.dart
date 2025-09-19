
// import 'package:bit_app/app/data/models/blood_request_model.dart';

// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:bit_app/services/request_service.dart';
// import 'package:bit_app/services/service_manifest.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class RequestDetailController extends GetxController {
//   // --- DEPENDENCIES ---
//   final RequestService _requestService = serviceLocator<RequestService>();
  
//   // --- UI STATE ---
//   final Rx<BloodRequestModel> request = Rx<BloodRequestModel>(
//     // Initialize with a dummy object to avoid null errors before loading.
//     BloodRequestModel(id: 0, requesterId: 0, name: '', phone: '', bloodType: '', quantity: 0, location: '', status: '', createdAt: DateTime.now(), updatedAt: DateTime.now())
//   );
//   final RxBool isLoading = true.obs;
//   final RxString errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Get the initial request data passed from the list screen
//     final initialRequest = Get.arguments as BloodRequestModel;
//     request.value = initialRequest;
    
//     // Immediately fetch the latest details for this request from the API
//     fetchRequestDetails(initialRequest.id);
//   }

//   /// Fetches the most up-to-date details for the request.
//   Future<void> fetchRequestDetails(int requestId) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';

//       final response = await _requestService.getBloodRequestById(requestId);
      
//       if (response.status == 'success' && response.data != null) {
//         request.value = BloodRequestModel.fromJson(response.data);
//       } else {
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       errorMessage.value = "An unexpected error occurred.";
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Opens the phone dialer with the requester's number.
//   Future<void> callNow() async {
//     final Uri phoneCallUri = Uri(scheme: 'tel', path: request.value.phone);
//     if (await canLaunchUrl(phoneCallUri)) {
//       await launchUrl(phoneCallUri);
//     } else {
//       Get.snackbar('Action Failed', 'Could not place a call to ${request.value.phone}.');
//     }
//   }

//   /// Shows a confirmation dialog when the user accepts the request.
//   void acceptRequest() {
//     // TODO: Implement an API call to PATCH/PUT the request status to "Accepted"
    
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.check_circle, color: AppColors.primaryRed, size: 50),
//               const SizedBox(height: 16),
//               const Text('Request Accepted!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               const Text(
//                 'Contact this user by clicking the call button',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () => Get.back());
//   }
// }
// import 'package:bit_app/app/data/models/blood_request_model.dart';

// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:bit_app/services/models/user_model.dart';
// import 'package:bit_app/services/request_service.dart';
// import 'package:bit_app/services/service_manifest.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart'; // Import GetStorage
// import 'package:url_launcher/url_launcher.dart';

// class RequestDetailController extends GetxController {
//   // --- DEPENDENCIES ---
//   final RequestService _requestService = serviceLocator<RequestService>();
//   final _storage = GetStorage();

//   // --- UI STATE ---
//   final Rx<BloodRequestModel> request = Rx<BloodRequestModel>(
//     BloodRequestModel(id: 0, requesterId: 0, name: '', phone: '', bloodType: '', quantity: 0, location: '', status: '', createdAt: DateTime.now(), updatedAt: DateTime.now())
//   );
//   final RxBool isLoadingPage = true.obs; // For the initial page load
//   final RxBool isAccepting = false.obs; // For the "Accept" button's loading state
//   final RxString errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final initialRequest = Get.arguments as BloodRequestModel;
//     request.value = initialRequest;
//     fetchRequestDetails(initialRequest.id);
//   }

//   Future<void> fetchRequestDetails(int requestId) async {
//     try {
//       isLoadingPage.value = true;
//       errorMessage.value = '';
//       final response = await _requestService.getBloodRequestById(requestId);
//       if (response.status == 'success' && response.data != null) {
//         request.value = BloodRequestModel.fromJson(response.data);
//       } else {
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       errorMessage.value = "An unexpected error occurred.";
//     } finally {
//       isLoadingPage.value = false;
//     }
//   }

//   Future<void> callNow() async {
//     final Uri phoneCallUri = Uri(scheme: 'tel', path: request.value.phone);
//     if (await canLaunchUrl(phoneCallUri)) {
//       await launchUrl(phoneCallUri);
//     } else {
//       Get.snackbar('Action Failed', 'Could not place a call to ${request.value.phone}.');
//     }
//   }

//   /// Handles the logic for accepting a blood request.
//   void acceptRequest() async {
//     // 1. Get the current user's ID from storage.
//     final userDataMap = _storage.read('user_data');
//     if (userDataMap == null) {
//       Get.snackbar('Error', 'Could not identify the current user. Please log in again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
//       return;
//     }
//     final currentUser = UserModel.fromJson(userDataMap);
//     final donorId = currentUser.uid;

//     isAccepting.value = true;
//     try {
//       // 2. Prepare the payload for the API.
//       final Map<String, dynamic> updateData = {
//         "donor_id": donorId,
//         "status": "Accepted", // Set the new status
//       };

//       // 3. Call the service to update the request.
//       final response = await _requestService.acceptBloodRequest(
//         requestId: request.value.id,
//         data: updateData,
//       );

//       if (response.status == 'success') {
//         // 4. Show the success dialog.
//         _showSuccessDialog();
//         // Optionally, refresh the request details to show the new "Accepted" status
//         fetchRequestDetails(request.value.id);
//       } else {
//         Get.snackbar('Failed', response.message, backgroundColor: Colors.redAccent, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An unexpected error occurred. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
//     } finally {
//       isAccepting.value = false;
//     }
//   }

//   /// Shows the confirmation dialog after successfully accepting a request.
//   void _showSuccessDialog() {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.check_circle, color: AppColors.primaryRed, size: 50),
//               const SizedBox(height: 16),
//               const Text('Request Accepted!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               const Text(
//                 'Contact this user by clicking the call button',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () => Get.back());
//   }
// }
// --- CORRECTED IMPORTS ---
import 'package:bit_app/app/data/models/blood_request_model.dart';

// --- END OF CORRECTIONS ---
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailController extends GetxController {
  // --- DEPENDENCIES (Now pointing to the correct services) ---
  final RequestService _requestService = serviceLocator<RequestService>();
  final _storage = GetStorage();

  // --- UI STATE ---
  final Rx<BloodRequestModel> request = Rx<BloodRequestModel>(
    BloodRequestModel(id: 0, requesterId: 0, name: '', phone: '', bloodType: '', quantity: 0, location: '', status: '', createdAt: DateTime.now(), updatedAt: DateTime.now())
  );
  final RxBool isLoadingPage = true.obs;
  final RxBool isAccepting = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final initialRequest = Get.arguments as BloodRequestModel;
    request.value = initialRequest;
    fetchRequestDetails(initialRequest.id);
  }
   Future<void> fetchRequestDetails(int requestId) async {
    try {
      isLoadingPage.value = true;
      errorMessage.value = '';
      final response = await _requestService.getBloodRequestById(requestId);
      
      if (response.status == 'success' && response.data != null) {
        print("--- Parsing successful response data ---");
        print("Raw data to be parsed: ${response.data}");
        request.value = BloodRequestModel.fromJson(response.data);
        print("--- Parsing SUCCESSFUL ---");
      } else {
        errorMessage.value = response.message;
      }
    } catch (e, stackTrace) {
      // --- THIS IS THE CRITICAL DEBUGGING BLOCK ---
      print("----------- PARSING EXCEPTION CAUGHT in RequestDetailController -----------");
      print("Error: $e");
      print("StackTrace: $stackTrace");
      print("-----------------------------------------------------------------------");
      errorMessage.value = "An unexpected error occurred while processing data.";
    } finally {
      isLoadingPage.value = false;
    }
  }
  // Future<void> fetchRequestDetails(int requestId) async {
  //   try {
  //     isLoadingPage.value = true;
  //     errorMessage.value = '';
  //     final response = await _requestService.getBloodRequestById(requestId);
  //     if (response.status == 'success' && response.data != null) {
  //       request.value = BloodRequestModel.fromJson(response.data);
  //     } else {
  //       errorMessage.value = response.message;
  //     }
  //   } catch (e) {
  //     errorMessage.value = "An unexpected error occurred.";
  //   } finally {
  //     isLoadingPage.value = false;
  //   }
  // }

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
    // This now uses the correct UserModel.fromJson
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