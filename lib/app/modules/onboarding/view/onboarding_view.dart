// import 'package:bit_app/app/modules/onboarding/controller/onboarding_controller.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// class OnBoardingView extends GetView<OnBoardingController> {
//   const OnBoardingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 1. Background Image PageView
//           PageView.builder(
//             controller: controller.pageController,
//             onPageChanged: controller.onPageChanged,
//             itemCount: controller.pages.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(controller.pages[index].imageAsset),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           ),

//           // 2. Top Logo
//           Positioned(
//             top: kToolbarHeight,
//             left: 0,
//             right: 0,
//             child: Image.asset('assets/imgs/logo_full.png', height: 100),
//           ),

//           // 3. Bottom Content Section
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _buildBottomSection(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomSection() {
//     return Obx(
//       () {
//         final info = controller.pages[controller.currentPageIndex.value];
//         return Container(
//           height: 300,
//           decoration: BoxDecoration(
//             color: info.circleColor.withOpacity(0.85),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(160),
//               topRight: Radius.circular(200),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Text(
//                   info.title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     height: 1.3,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               _buildNavigationControls(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildNavigationControls() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Page Indicator
//           SmoothPageIndicator(
//             controller: controller.pageController,
//             count: controller.pages.length,
//             effect: const WormEffect(
//               dotHeight: 10,
//               dotWidth: 10,
//               activeDotColor: Colors.white,
//               dotColor: Colors.white54,
//             ),
//           ),

//           // Next Button or Get Started Button
//           Obx(
//             () => controller.currentPageIndex.value == controller.pages.length - 1
//                 ? _buildGetStartedButton()
//                 : _buildNextButton(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return GestureDetector(
//       onTap: controller.animateToNextPage,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.2),
//           shape: BoxShape.circle,
//         ),
//         child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
//       ),
//     );
//   }

//   Widget _buildGetStartedButton() {
//     return ElevatedButton(
//       onPressed: controller.navigateToHome,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryRed,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//       ),
//       child: const Text(
//         'Get Started',
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }


import 'package:bit_app/app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:bit_app/app/utils/app_colors.dart'; // Make sure this path is correct

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) { // The 'context' variable lives here
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.pages[index].imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // 2. Top Logo
          Positioned(
            top: kToolbarHeight,
            left: 0,
            right: 0,
            child: Image.asset('assets/imgs/logo_full.png', height: 100),
          ),

          // 3. Bottom Content Section
          // THE FIX (PART 1): We now pass 'context' to the method below.
          _buildBottomSection(context),
        ],
      ),
    );
  }

  // THE FIX (PART 2): The method now accepts the 'context' variable.
  Widget _buildBottomSection(BuildContext context) {
    // Now this line is valid because 'context' has been passed in.
    final screenWidth = MediaQuery.of(context).size.width;
    const double arcHeight = 320.0; // Increased height for a more prominent curve

    return Positioned(
      bottom: 0,
      left: 0,
      right: 10,
      child: Obx(() {
        final info = controller.pages[controller.currentPageIndex.value];
        return Container(
          width: screenWidth,
          height: arcHeight,
          decoration: BoxDecoration(
            color: info.circleColor.withOpacity(0.85),
            // Using a large radius creates the smooth arc effect
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(200),
              bottomRight: Radius.circular(180)
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  info.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildNavigationControls(),
            ],
          ),
        );
      }),
    );
  }

  // --- NO CHANGES to the widgets below ---

  Widget _buildNavigationControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.pages.length,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.white,
              dotColor: Colors.white54,
            ),
          ),
          Obx(
            () => controller.currentPageIndex.value == controller.pages.length - 1
                ? _buildGetStartedButton()
                : _buildNextButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: controller.animateToNextPage,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return ElevatedButton(
      onPressed: controller.navigateToHome,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}