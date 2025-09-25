import 'package:bit_app/app/modules/blood_request/view/blood_request_view.dart';
import 'package:bit_app/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:bit_app/app/modules/requests_list/controller/requests_list_controller.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:bit_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum RequestType { self, others }

class BloodRequestController extends GetxController {
  // --- DEPENDENCIES ---
  final RequestService _requestService = Get.find<RequestService>();
  final UserService _userService = Get.find<UserService>();
  final _storage = GetStorage();

  // --- FORM STATE ---
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final reasonController = TextEditingController();
  final Rx<RequestType> requestType = RequestType.self.obs;
  final RxString selectedBloodGroup = ''.obs;
  final RxInt selectedPints = 0.obs;
  final RxBool isLoading = false.obs;

  // --- STATIC DATA ---
  final List<String> bloodGroups = const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final List<int> pintUnits = const [1, 2, 3, 4, 5, 6];

  // --- USER DATA ---
  late UserModel _currentUser;

  @override
  void onInit() {
    super.onInit();
    _loadUserDataAndInitializeForm();
  }

  void _loadUserDataAndInitializeForm() {
    final userDataMap = _storage.read('user_data');
    if (userDataMap != null) {
      _currentUser = UserModel.fromJson(userDataMap);
    } else {
      // Create a default user if none is stored
      _currentUser = UserModel(
        uid: 'mock_user_123',
        username: "Mock User",
        phone: "08012345678",
        email: 'mock@example.com',
        location: '',
        dateOfBirth: '',
        gender: '',
        bloodType: '',
      );
    }
    setRequestType(RequestType.self);
  }

  void setRequestType(RequestType type) {
    requestType.value = type;
    if (type == RequestType.self) {
      nameController.text = _currentUser.username;
      mobileController.text = _currentUser.phone;
    } else {
      nameController.clear();
      mobileController.clear();
    }
  }

  void selectBloodGroup(String group) => selectedBloodGroup.value = group;
  void selectPints(int pints) => selectedPints.value = pints;

  void submitRequest() async {
    if (!_validateForm()) return;
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestData = {
        "blood_type": selectedBloodGroup.value,
        "quantity": selectedPints.value,
        "location": locationController.text.trim(),
        "requester_id": _currentUser.uid,
        "name": nameController.text.trim(),
        "phone": mobileController.text.trim(),
        if (reasonController.text.trim().isNotEmpty) "reason": reasonController.text.trim(),
      };

      final response = await _requestService.createBloodRequest(requestData);

      if (response.status == 'success') {
        // Refetch user data to update the request count
        final userResponse = await _userService.getProfile();
        if (userResponse.status == 'success') {
          _storage.write('user_data', userResponse.data);
        }

        if (Get.isRegistered<RequestsListController>()) {
          Get.find<RequestsListController>().fetchRequests();
        }

        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().changeTabIndex(1);
        }

        Get.back();
        Get.snackbar(
          'Success',
          'Your blood request has been submitted successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

      } else {
        Get.snackbar('Request Failed', response.message, backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (nameController.text.trim().isEmpty || mobileController.text.trim().isEmpty || selectedBloodGroup.value.isEmpty || selectedPints.value == 0 || locationController.text.trim().isEmpty) {
      Get.snackbar('Incomplete Form', 'Please fill all required fields.', backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    locationController.dispose();
    reasonController.dispose();
    super.onClose();
  }
}
