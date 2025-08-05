import 'package:bit_app/app/modules/blood_request/view/blood_request_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';

// Enum for clarity
enum RequestType { self, others }

class BloodRequestController extends GetxController {
  // --- Form State Variables ---
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final reasonController = TextEditingController();

  final Rx<RequestType> requestType = RequestType.self.obs;
  final RxString selectedBloodGroup = ''.obs;
  final RxInt selectedPints = 0.obs;

  // --- Static Data ---
  final List<String> bloodGroups = const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final List<int> pintUnits = const [1, 2, 3, 4, 5, 6];
  
  // --- Mock User Data (in a real app, this would come from a user service) ---
  final String _userName = "User Name";
  final String _userMobile = "08022834848";

  @override
  void onInit() {
    super.onInit();
    // Initialize the form for 'Self'
    setRequestType(RequestType.self);
  }

  /// Sets the request type and updates the form fields accordingly.
  void setRequestType(RequestType type) {
    requestType.value = type;
    if (type == RequestType.self) {
      nameController.text = _userName;
      mobileController.text = _userMobile;
    } else {
      nameController.clear();
      mobileController.clear();
    }
  }

  /// Updates the selected blood group.
  void selectBloodGroup(String group) {
    selectedBloodGroup.value = group;
  }

  /// Updates the selected number of pints.
  void selectPints(int pints) {
    selectedPints.value = pints;
  }

  /// Validates the form and submits the request.
  void submitRequest() {
    // TODO: Add full validation logic
    if (selectedBloodGroup.value.isEmpty || selectedPints.value == 0 || locationController.text.isEmpty) {
       Get.snackbar(
        'Incomplete Form', 
        'Please fill all required fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    print('Submitting request...');
    // TODO: Add API call to submit data to the backend

    // On success, show the confirmation dialog
    Get.dialog(const RequestSuccessDialog(), barrierDismissible: false);
    
    // After a delay, close the dialog and go back
    Future.delayed(const Duration(seconds: 3), () {
      Get.back(); // Close the dialog
      Get.back(); // Go back from the form screen
    });
  }

  @override
  void onClose() {
    // Dispose all controllers
    nameController.dispose();
    mobileController.dispose();
    locationController.dispose();
    reasonController.dispose();
    super.onClose();
  }
}