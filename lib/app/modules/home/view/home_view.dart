
// import 'package:bit_app/app/modules/widgets/app_bar_drawer.dart';
// import 'package:bit_app/app/routes/app_routes.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../controller/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: controller.scaffoldKey, // Attach the key to the Scaffold
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: controller.openDrawer, // Use the controller to open the drawer
//         ),
//       ),
//       drawer: const AppDrawer(), // Add the drawer here
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildWelcomeBanner(),
//             const SizedBox(height: 24),
//             _buildActionButtons(), 
//             const SizedBox(height: 24),
//             _buildInfoCard(),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeBanner() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 150,
//           child: PageView(
//             controller: controller.bannerController,
//             children: [
//               _bannerItem('assets/imgs/background.png', 'Welcome USERNAME!'),
//               _bannerItem('assets/imgs/background.png', 'Give Blood, Give Life!'),
//               _bannerItem('assets/imgs/background.png', 'Give Blood, Give Life!'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         SmoothPageIndicator(
//           controller: controller.bannerController,
//           count: 3,
//           effect: const ScrollingDotsEffect(
//             activeDotColor: AppColors.primaryTeal,
//             dotColor: Colors.grey,
//             dotHeight: 8,
//             dotWidth: 8,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _bannerItem(String imagePath, String text) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(text, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
//           const Text('Help donate to save a live!', style: TextStyle(color: Colors.white70, fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   // UPDATED METHOD
//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _actionButton(
//          icon: Icons.search,
//          label: 'Find Donor',
//         color: AppColors.primaryRed,
//         onTap: () => Get.toNamed(AppRoutes.FIND_DONOR), // This line triggers the feature
// ),
//         _actionButton(
//           icon: Icons.bloodtype,
//           label: 'Request',
//           color: AppColors.primaryRed,
//           onTap: () => Get.toNamed(AppRoutes.BLOOD_REQUEST), // Correct navigation
//         ),
//         _actionButton(
//           icon: Icons.volunteer_activism,
//           label: 'Donate',
//           color: AppColors.primaryRed,
//           onTap: () {
//             Get.snackbar('Coming Soon', 'Donate functionality will be added later.');
//           },
//         ),
//       ],
//     );
//   }

//   // UPDATED WIDGET
//   Widget _actionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(icon, color: color, size: 40),
//           ),
//           const SizedBox(height: 8),
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Who can donate blood?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(
//             'This list of requirements from World Health Organization (WHO) can help you learn if you can donate blood',
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 16),
//           Align(
//             alignment: Alignment.center,
//             child: OutlinedButton(
//               onPressed: () {},
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: AppColors.primaryTeal),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               ),
//               child: const Text('See More', style: TextStyle(color: AppColors.primaryTeal)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:bit_app/app/modules/widgets/app_bar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // THE FIX: Changed icon color to match the design.
          icon: const Icon(Icons.menu, color: AppColors.primaryRed),
          onPressed: controller.openDrawer,
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        // Added padding for better overall spacing from screen edges.
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _buildWelcomeBanner(),
            const SizedBox(height: 24),
            _buildActionButtons(),
            const SizedBox(height: 24),
            _buildInfoCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    // This widget was already good, ensuring the asset path is correct.
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: controller.bannerController,
            children: [
              _bannerItem('assets/imgs/background.png',  'Welcome USERNAME!'),
              _bannerItem('assets/imgs/background.png', 'Give Blood, Give Life!'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: controller.bannerController,
          count: 3,
          effect: const ScrollingDotsEffect(
            activeDotColor: AppColors.primaryTeal,
            dotColor: Colors.grey,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _bannerItem(String imagePath, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('Help donate to save a live!', style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  // REWRITTEN METHOD: Uses padding for better spacing.
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(
            imagePath: 'assets/imgs/search.png',
            label: 'Find Donor',
            onTap: () => Get.toNamed(AppRoutes.FIND_DONOR),
          ),
          _actionButton(
            imagePath: 'assets/imgs/blood_bag.png',
            label: 'Request',
            onTap: () => Get.toNamed(AppRoutes.BLOOD_REQUEST),
          ),
          _actionButton(
            imagePath: 'assets/imgs/donate.png',
            label: 'Donate',
                onTap: () => Get.toNamed(AppRoutes.FIND_DONOR),
            // onTap: () {
            //   Get.snackbar('Coming Soon', 'Donate functionality will be added later.');
            // },
          ),
        ],
      ),
    );
  }

  // REWRITTEN WIDGET: This now perfectly matches the design.
  Widget _actionButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105,  // Ensures uniform size
        height: 110, // Ensures uniform size
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(15),
          boxShadow: [ // Subtle shadow for elevation
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        // THE FIX: Column is now INSIDE the container.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // THE FIX: Using Image.asset instead of Icon.
            Image.asset(imagePath, height: 40),
            const SizedBox(height: 8),
            // THE FIX: Text color is now grey.
            Text(label, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // REWRITTEN WIDGET: Styling is now consistent with action buttons.
  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // THE FIX: Consistent styling with white background and shadow.
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Who can donate blood?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          const SizedBox(height: 8),
          Text(
            'This list of requirements from World Health Organization (WHO) can help you learn if you can donate blood',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryTeal),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 40),
              ),
              child: const Text('See More', style: TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}