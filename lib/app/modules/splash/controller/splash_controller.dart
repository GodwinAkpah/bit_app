import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  // 0: Gradient Red-Teal
  // 1: Gradient Red-White-Teal
  // 2: White
  final RxInt screenIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    // Show the first screen immediately
    // Then wait 1.5 seconds to transition to the next
    Timer(const Duration(milliseconds: 1500), () {
      screenIndex.value = 1; // Transition to the second screen
    });

    // Wait 3 seconds total to transition to the third
    Timer(const Duration(milliseconds: 3000), () {
      screenIndex.value = 2; // Transition to the third screen
    });

    // After 4.5 seconds, navigate to the main onboarding screen
    Timer(const Duration(milliseconds: 4500), () {
      // Use offAllNamed to prevent the user from going back to the splash
      Get.offAllNamed(AppRoutes.ON_BOARDING);
    });
  }
}