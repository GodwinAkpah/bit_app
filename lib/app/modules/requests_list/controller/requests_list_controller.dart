import 'package:bit_app/app/data/models/blood_request_model.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:get/get.dart';

class RequestsListController extends GetxController {
  // --- DEPENDENCIES ---
  final RequestService _requestService = Get.find<RequestService>();

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
        
        final List<BloodRequestModel> fetchedRequests = [];
        for (var requestJson in responseData) {
          try {
            if (requestJson is Map<String, dynamic>) {
              // --- CORRECTED TYPO HERE ---
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

  /// Navigates to the detail page and then refreshes the list when the user returns.
  void viewRequestDetails(BloodRequestModel request) async {
    // Navigate and wait for the detail page to be closed.
    await Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
    
    // When the user comes back, refresh the list to see any status changes.
    fetchRequests();
  }
}
