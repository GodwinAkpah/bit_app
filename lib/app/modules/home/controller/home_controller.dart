import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController bannerController = PageController();

  final AuthService _authService = Get.find<AuthService>();

  // Use Rx<UserModel> to make it reactive
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  // Function to open the drawer
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch user data when the controller is initialized
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await _authService.getMe();
      if (response.status == 'success') {
        // Assuming the user data is in the 'data' field of the response
        user.value = UserModel.fromJson(response.data!['data']);
      } else {
        // Handle error case, e.g., show a snackbar
        Get.snackbar('Error', 'Failed to fetch user data');
      }
    } catch (e) {
      // Handle exception
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onClose() {
    bannerController.dispose();
    super.onClose();
  }
}
