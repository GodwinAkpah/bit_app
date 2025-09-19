

// import 'package:bit_app/app/modules/blood_request/view/blood_request_view.dart';
// import 'package:bit_app/services/models/user_model.dart';
// import 'package:bit_app/services/request_service.dart';
// import 'package:bit_app/services/service_manifest.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get_storage/get_storage.dart';


// enum RequestType { self, others }

// class BloodRequestController extends GetxController {
//   final RequestService _requestService = serviceLocator<RequestService>();
//   final _storage = GetStorage();

//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final locationController = TextEditingController();
//   final reasonController = TextEditingController();
//   final Rx<RequestType> requestType = RequestType.self.obs;
//   final RxString selectedBloodGroup = ''.obs;
//   final RxInt selectedPints = 0.obs;
//   final RxBool isLoading = false.obs;

//   final List<String> bloodGroups = const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
//   final List<int> pintUnits = const [1, 2, 3, 4, 5, 6];
  
//   late UserModel _currentUser;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadUserDataAndInitializeForm();
//   }

//   void _loadUserDataAndInitializeForm() {
//     final userDataMap = _storage.read('user_data');
//     if (userDataMap != null) {
//       _currentUser = UserModel.fromJson(userDataMap);
//     } else {
//       _currentUser = UserModel(
//         uid: 'mock_user_123',
//         username: "Mock User",
//         phone: "08012345678",
//         email: 'mock@example.com',
//         location: '',
//         dateOfBirth: '',
//         gender: '',
//         bloodType: '',
//       );
//     }
//     setRequestType(RequestType.self);
//   }

//   void setRequestType(RequestType type) {
//     requestType.value = type;
//     if (type == RequestType.self) {
//       nameController.text = _currentUser.username;
//       mobileController.text = _currentUser.phone;
//     } else {
//       nameController.clear();
//       mobileController.clear();
//     }
//   }

//   void selectBloodGroup(String group) => selectedBloodGroup.value = group;
//   void selectPints(int pints) => selectedPints.value = pints;

//   void submitRequest() async {
//     if (!_validateForm()) return;
//     isLoading.value = true;
//     try {
//       final Map<String, dynamic> requestData = {
//         "blood_type": selectedBloodGroup.value,
//         "quantity": selectedPints.value,
//         "location": locationController.text.trim(),
//         "donor_id": _currentUser.uid,
//         "name": nameController.text.trim(),
//         "phone": mobileController.text.trim(),
//         if (reasonController.text.trim().isNotEmpty) "reason": reasonController.text.trim(),
//       };
      
//       final response = await _requestService.createBloodRequest(requestData);

//       if (response.status == 'success') {
//         Get.dialog(const RequestSuccessDialog(), barrierDismissible: false);
//         Future.delayed(const Duration(seconds: 3), () {
//           Get.back(); // Close dialog
//           Get.back(); // Go back from form screen
//         });
//       } else {
//         Get.snackbar('Request success', response.message, backgroundColor: Colors.redAccent, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An unexpected error occurred. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   bool _validateForm() {
//     if (nameController.text.trim().isEmpty || mobileController.text.trim().isEmpty || selectedBloodGroup.value.isEmpty || selectedPints.value == 0 || locationController.text.trim().isEmpty) {
//       Get.snackbar('Incomplete Form', 'Please fill all required fields.', backgroundColor: Colors.orange, colorText: Colors.white);
//       return false;
//     }
//     return true;
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     mobileController.dispose();
//     locationController.dispose();
//     reasonController.dispose();
//     super.onClose();
//   }
// }

// --- CORRECTED IMPORTS ---

import 'package:bit_app/app/modules/blood_request/view/blood_request_view.dart';
import 'package:bit_app/app/modules/requests_list/controller/requests_list_controller.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum RequestType { self, others }

class BloodRequestController extends GetxController {
  // --- DEPENDENCIES (Now pointing to the correct services) ---
  final RequestService _requestService = serviceLocator<RequestService>();
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
  
  // --- USER DATA (Using the correct UserModel) ---
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
        "donor_id": _currentUser.uid,
        "name": nameController.text.trim(),
        "phone": mobileController.text.trim(),
        if (reasonController.text.trim().isNotEmpty) "reason": reasonController.text.trim(),
      };
      
      final response = await _requestService.createBloodRequest(requestData);

      if (response.status == 'success') {
        // --- THE FIX TO REFRESH THE LIST ---
        // 2. Check if the controller exists in memory and then call its refresh method.
        if (Get.isRegistered<RequestsListController>()) {
          final requestsListController = Get.find<RequestsListController>();
          requestsListController.fetchRequests();
          print("Successfully triggered list refresh.");
        }
        // --- END OF FIX ---
        
        Get.dialog(const RequestSuccessDialog(), barrierDismissible: false);
        Future.delayed(const Duration(seconds: 3), () {
          Get.back(); // Close dialog
          Get.back(); // Go back from form screen
        });
      } else {
        Get.snackbar('Request Failed', response.message, backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
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