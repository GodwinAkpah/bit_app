import 'package:bit_app/app/modules/splash/controller/splash_controller.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(SplashController());

    return Scaffold(
      body: Obx(
        () {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Container(
              // The key is essential for AnimatedSwitcher to detect a widget change
              key: ValueKey<int>(controller.screenIndex.value),
              decoration: _buildBackgroundDecoration(controller.screenIndex.value),
              child: Center(
                // The Column and Text widgets are removed.
                // We just display the single logo image.
                child: Image.asset(
                  'assets/imgs/logo_full.png', // Using the full logo image
                  width: 220, // Adjust the width as needed for proper scaling
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration(int index) {
    switch (index) {
      case 0: // Screen 1: Red to Teal Vertical Gradient
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryRed, AppColors.primaryTeal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      case 1: // Screen 2: Red to White to Teal Diagonal Gradient
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryRed, AppColors.white, AppColors.primaryTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        );
      case 2: // Screen 3: Plain White
      default:
        return BoxDecoration(
          // Using lightGray from your design instead of pure white for the third screen
          color: AppColors.lightGray,
        );
    }
  }
}