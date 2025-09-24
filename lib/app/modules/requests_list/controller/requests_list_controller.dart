
// import 'package:bit_app/app/data/models/blood_request_model.dart';
// import 'package:bit_app/app/routes/app_routes.dart';
// import 'package:bit_app/services/request_service.dart';
// import 'package:bit_app/services/service_manifest.dart';

// import 'package:get/get.dart';

// class RequestsListController extends GetxController {
//   // --- DEPENDENCIES ---
//   final RequestService _requestService = serviceLocator<RequestService>();

//   // --- UI STATE ---
//   final RxList<BloodRequestModel> requests = <BloodRequestModel>[].obs;
//   final RxBool isLoading = true.obs; // Start in loading state
//   final RxString errorMessage = ''.obs; // To store any error messages

//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch requests when the controller is first created
//     fetchRequests();
//   }

//   /// Fetches the list of blood requests from the API.
//   Future<void> fetchRequests() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = ''; // Clear previous errors

//       final response = await _requestService.getBloodRequests();

//       if (response.status == 'success' && response.data != null) {
//         // The API returns a List of maps. We need to convert this list.
//         final List<dynamic> responseData = response.data as List;
        
//         // Use fromJson to convert each map in the list to a BloodRequestModel
//         final List<BloodRequestModel> fetchedRequests = responseData
//             .map((requestJson) => BloodRequestModel.fromJson(requestJson))
//             .toList();

//         // Update the reactive list with the fetched data
//         requests.assignAll(fetchedRequests);
//       } else {
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       print("Fetch Requests Error: $e");
//       errorMessage.value = 'An unexpected error occurred.';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Navigates to the detail page for a specific request.
//   void viewRequestDetails(BloodRequestModel request) {
//     // We will need to create the RequestDetail screen next to handle this
//     Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
//   }
// }
// import 'package:bit_app/app/data/models/blood_request_model.dart'; 

// import 'package:bit_app/app/routes/app_routes.dart';
// import 'package:bit_app/services/request_service.dart';
// import 'package:bit_app/services/service_manifest.dart';
// import 'package:get/get.dart';

// class RequestsListController extends GetxController {
//   // --- DEPENDENCIES ---
//   final RequestService _requestService = serviceLocator<RequestService>();

//   // --- UI STATE ---
//   final RxList<BloodRequestModel> requests = <BloodRequestModel>[].obs;
//   final RxBool isLoading = true.obs;
//   final RxString errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchRequests();
//   }

//   /// Fetches the list of blood requests from the API.
//   Future<void> fetchRequests() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';

//       final response = await _requestService.getBloodRequests();

//       if (response.status == 'success' && response.data != null) {
//         final List<dynamic> responseData = response.data as List;
        
//         // --- THIS IS THE BULLETPROOF PARSING LOGIC ---
//         final List<BloodRequestModel> fetchedRequests = [];
//         for (var requestJson in responseData) {
//           try {
//             // Try to parse each item individually
//             fetchedRequests.add(BloodRequestModel.fromJson(requestJson));
//           } catch (e, stackTrace) {
//             // If one item fails, print a detailed error and skip it
//             print("----------- FAILED TO PARSE ONE REQUEST ITEM -----------");
//             print("Error: $e");
//             print("Problematic JSON: $requestJson");
//             print("StackTrace: $stackTrace");
//             print("-------------------------------------------------------");
//           }
//         }
//         // --- END OF PARSING LOGIC ---

//         requests.assignAll(fetchedRequests);
//       } else {
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       print("Fetch Requests Error: $e");
//       errorMessage.value = 'An unexpected error occurred.';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Navigates to the detail page for a specific request.
//   void viewRequestDetails(BloodRequestModel request) {
//     Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
//   }
// }
import 'package:bit_app/app/data/models/blood_request_model.dart';

import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:get/get.dart';

class RequestsListController extends GetxController {
  // --- DEPENDENCIES ---
  final RequestService _requestService = serviceLocator<RequestService>();

  // --- UI STATE ---
  final RxList<BloodRequestModel> requests = <BloodRequestModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  /// Fetches the list of blood requests from the API with robust error handling.
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _requestService.getBloodRequests();

      if (response.status == 'success' && response.data != null) {
        final List<dynamic> responseData = response.data as List;
        
        // --- THIS IS THE BULLETPROOF PARSING LOGIC ---
        final List<BloodRequestModel> fetchedRequests = [];
        for (var requestJson in responseData) {
          try {
            // Try to parse each item individually.
            if (requestJson is Map<String, dynamic>) {
              fetchedRequests.add(BloodRequestModel.fromJson(requestJson));
            }
          } catch (e, stackTrace) {
            // If one item fails, print a detailed error and SKIP IT.
            print("----------- FAILED TO PARSE ONE REQUEST ITEM -----------");
            print("Error: $e");
            print("Problematic JSON: $requestJson");
            print("StackTrace: $stackTrace");
            print("-------------------------------------------------------");
          }
        }
        // --- END OF PARSING LOGIC ---

        requests.assignAll(fetchedRequests);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      print("Fetch Requests Error: $e");
      errorMessage.value = 'An unexpected error occurred while fetching the list.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigates to the detail page for a specific request.
  void viewRequestDetails(BloodRequestModel request) {
    Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
  }
}