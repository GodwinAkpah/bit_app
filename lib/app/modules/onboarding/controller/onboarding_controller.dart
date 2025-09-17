import 'package:bit_app/app/modules/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';


class OnBoardingController extends GetxController {
  late PageController pageController;

  // Use RxInt to make the current page index reactive
  final RxInt currentPageIndex = 0.obs;

  // List of onboarding pages data
  final List<OnBoardingInfo> pages = [
    OnBoardingInfo(
      imageAsset: 'assets/imgs/onboarding1.jpg',
      title: 'Become a blood\ndonor and save\nlives',
      circleColor: AppColors.primaryRed,
    ),
    OnBoardingInfo(
      imageAsset: 'assets/imgs/onboarding2.jpg',
      title: 'Request Blood\nFrom Any\nBloodGroup',
      circleColor: AppColors.primaryTeal,
    ),
    OnBoardingInfo(
      imageAsset: 'assets/imgs/onboarding3.jpg',
      title: 'Find Blood Donors\nAnd You Can\nReach Them Too',
      circleColor: AppColors.primaryTeal,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  /// Callback function for when the page changes
  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }

  /// Animate to the next page in the PageView
  void animateToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  /// Navigate to the Home screen and clear the navigation stack
  void navigateToHome() {
    // offAllNamed clears all previous routes, so the user can't go back
    // to onboarding or login/signup from the home screen.
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}