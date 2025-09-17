
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:bit_app/app/modules/home/view/home_view.dart';
import 'package:bit_app/app/modules/profile/view/profile_view.dart';
import 'package:bit_app/app/modules/requests_list/view/requests_list_view.dart';
import 'package:bit_app/app/utils/app_colors.dart'; // Make sure this path is correct

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: const [
          HomeView(),
          RequestsListView(),
          ProfileView(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.tabIndex.value,
        onTap: controller.changeTabIndex,
        
        // --- STYLING ---
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        
        // --- ITEMS ---
        items: [
          _buildNavItem(
            imagePath: 'assets/imgs/home.png',
            index: 0,
          ),
          _buildNavItem(
            imagePath: 'assets/imgs/notify.png',
            index: 1,
          ),
          _buildNavItem(
            imagePath: 'assets/imgs/profile.png',
            index: 2,
          ),
        ],
      )),
    );
  }

  // --- NEW HELPER METHOD TO BUILD EACH ITEM ---
  BottomNavigationBarItem _buildNavItem({
    required String imagePath,
    required int index,
  }) {
    // Check if the current item's index matches the controller's active tab index.
    final bool isActive = controller.tabIndex.value == index;

    return BottomNavigationBarItem(
      // The `icon` property is used for both active and inactive states.
      // We will handle the visual difference with our custom wrapper.
      icon: Container(
        padding: const EdgeInsets.all(6), // Add some space between the image and the border
        decoration: BoxDecoration(
          // THE FIX: Conditionally apply a red border if the tab is active.
          border: isActive
              ? const Border(top: BorderSide(color: AppColors.primaryRed, width: 2.0))
              : null,
        ),
        child: Image.asset(
          imagePath,
          height: 30,
          // THE FIX: Conditionally apply a red color overlay if the tab is active.
          color: isActive ? AppColors.primaryRed : Colors.grey,
        ),
      ),
      label: '', // Label must be provided but is not shown.
    );
  }
}