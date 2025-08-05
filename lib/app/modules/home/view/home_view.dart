// import 'package:bit_app/app/modules/widgets/app_bar_drawer.dart';
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
//               _bannerItem('assets/images/banner_bg.png', 'Welcome USERNAME!'),
//               _bannerItem('assets/images/banner_bg.png', 'Give Blood, Give Life!'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         SmoothPageIndicator(
//           controller: controller.bannerController,
//           count: 2,
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

//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _actionButton(icon: Icons.search, label: 'Find Donor', color: AppColors.primaryRed),
//         _actionButton(icon: Icons.bloodtype, label: 'Request', color: AppColors.primaryRed),
//         _actionButton(icon: Icons.volunteer_activism, label: 'Donate', color: AppColors.primaryRed),
//       ],
//     );
//   }

//   Widget _actionButton({required IconData icon, required String label, required Color color}) {
//     return Column(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Icon(icon, color: color, size: 40),
//         ),
//         const SizedBox(height: 8),
//         Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//       ],
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
//           const Text('Who can donate blood?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey, // Attach the key to the Scaffold
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: controller.openDrawer, // Use the controller to open the drawer
        ),
      ),
      drawer: const AppDrawer(), // Add the drawer here
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWelcomeBanner(),
            const SizedBox(height: 24),
            _buildActionButtons(), // This method is now updated
            const SizedBox(height: 24),
            _buildInfoCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: controller.bannerController,
            children: [
              _bannerItem('assets/images/banner_bg.png', 'Welcome USERNAME!'),
              _bannerItem('assets/images/banner_bg.png', 'Give Blood, Give Life!'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: controller.bannerController,
          count: 2,
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
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

  // UPDATED METHOD
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(
         icon: Icons.search,
         label: 'Find Donor',
        color: AppColors.primaryRed,
        onTap: () => Get.toNamed(AppRoutes.FIND_DONOR), // This line triggers the feature
),
        _actionButton(
          icon: Icons.bloodtype,
          label: 'Request',
          color: AppColors.primaryRed,
          onTap: () => Get.toNamed(AppRoutes.BLOOD_REQUEST), // Correct navigation
        ),
        _actionButton(
          icon: Icons.volunteer_activism,
          label: 'Donate',
          color: AppColors.primaryRed,
          onTap: () {
            Get.snackbar('Coming Soon', 'Donate functionality will be added later.');
          },
        ),
      ],
    );
  }

  // UPDATED WIDGET
  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Who can donate blood?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              ),
              child: const Text('See More', style: TextStyle(color: AppColors.primaryTeal)),
            ),
          ),
        ],
      ),
    );
  }
}