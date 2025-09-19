// import 'package:get/get.dart';
// import '../../../data/models/blood_request_model.dart';
// import '../../../routes/app_routes.dart';

// class RequestsListController extends GetxController {
//   // Mock data. In a real app, this comes from an API.
//   final RxList<BloodRequestModel> requests = <BloodRequestModel>[
//     BloodRequestModel(id: '1', name: 'James Davou', location: 'TUDUN WADA, PLATEAU', bloodType: 'O-', unitsNeeded: 3, phone: '08012345678', reason: 'Patient has sickle cells anemia, she requires blood transfusion on regular basis to stay healthy and look. Your blood donation will help her be what she loves.'),
//     BloodRequestModel(id: '2', name: 'Veirat Davou', location: 'TUDUN WADA, PLATEAU', bloodType: 'AB+', unitsNeeded: 5, phone: '08012345678', reason: 'Emergency surgery requirement.'),
//     BloodRequestModel(id: '3', name: 'King David', location: 'TUDUN WADA, PLATEAU', bloodType: 'B-', unitsNeeded: 5, phone: '08012345678', reason: 'Post-accident trauma care.'),
//     BloodRequestModel(id: '4', name: 'Christian Simons', location: 'TUDUN WADA, PLATEAU', bloodType: 'O+', unitsNeeded: 1, phone: '08012345678', reason: 'Scheduled operation.'),
//     BloodRequestModel(id: '5', name: 'Elizabeth Mark', location: 'TUDUN WADA, PLATEAU', bloodType: 'B+', unitsNeeded: 6, phone: '08012345678', reason: 'Treatment for a chronic condition.'),
//   ].obs;

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
  final RxBool isLoading = true.obs; // Start in loading state
  final RxString errorMessage = ''.obs; // To store any error messages

  @override
  void onInit() {
    super.onInit();
    // Fetch requests when the controller is first created
    fetchRequests();
  }

  /// Fetches the list of blood requests from the API.
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors

      final response = await _requestService.getBloodRequests();

      if (response.status == 'success' && response.data != null) {
        // The API returns a List of maps. We need to convert this list.
        final List<dynamic> responseData = response.data as List;
        
        // Use fromJson to convert each map in the list to a BloodRequestModel
        final List<BloodRequestModel> fetchedRequests = responseData
            .map((requestJson) => BloodRequestModel.fromJson(requestJson))
            .toList();

        // Update the reactive list with the fetched data
        requests.assignAll(fetchedRequests);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      print("Fetch Requests Error: $e");
      errorMessage.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigates to the detail page for a specific request.
  void viewRequestDetails(BloodRequestModel request) {
    // We will need to create the RequestDetail screen next to handle this
    Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
  }
}