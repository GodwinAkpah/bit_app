import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:bit_app/app/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  // THE FIX: Removed 'const' from the constructor.
  AppDrawer({super.key});

  // A reactive variable to track the currently selected item.
  // We'll use this to show the red "hover" effect.
  final RxString selectedItem = RxString('Profile');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0, // A clean, flat look
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: kToolbarHeight + 20),
            _buildDrawerHeader(),
            const SizedBox(height: 30),

            _buildDrawerItem(imagePath: 'assets/imgs/user.png', text: 'Profile', route: AppRoutes.PROFILE),
            _buildDrawerItem(imagePath: 'assets/imgs/inbox.png', text: 'Inbox', badge: '+10'),
            _buildDrawerItem(imagePath: 'assets/imgs/blood_bag.png', text: 'Request History'),
            _buildDrawerItem(imagePath: 'assets/imgs/donate.png', text: 'Donate History'),
            _buildDrawerItem(imagePath: 'assets/imgs/notifications-outline.png', text: 'Notifications', hasDot: true, route: AppRoutes.NOTIFICATIONS),
            _buildDrawerItem(imagePath: 'assets/imgs/icon.png', text: 'Settings'),
            
            const SizedBox(height: 30),
            const Divider(), // A subtle divider
            const SizedBox(height: 30),

            // Help and Sign Out buttons with custom design
            _buildOutlinedButton(imagePath: 'assets/imgs/icon.png', text: 'Help'),
            const SizedBox(height: 12),
            _buildOutlinedButton(imagePath: 'assets/imgs/sup.png', text: 'Sign out', route: AppRoutes.LOGIN, isSignOut: true),
            
            const SizedBox(height: 30),
            _buildSupportButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/imgs/por.png'), // Add user profile image
        ),
        const SizedBox(height: 16),
        const Text(
          'Username',
          style: TextStyle(
            color: AppColors.primaryRed,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required String imagePath,
    required String text,
    String? route,
    String? badge,
    bool hasDot = false,
  }) {
    return Obx(() {
      final bool isSelected = selectedItem.value == text;
      return GestureDetector(
        onTap: () {
          selectedItem.value = text;
          Get.back(); // Close the drawer
          if (route != null) {
            Get.toNamed(route);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryRed : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryRed.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 22,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              const Spacer(),
              if (hasDot)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryRed,
                    shape: BoxShape.circle,
                  ),
                ),
              if (badge != null)
                Text(
                  badge,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildOutlinedButton({
    required String imagePath,
    required String text,
    String? route,
    bool isSignOut = false,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back();
        if (route != null) {
          if (isSignOut) {
            Get.offAllNamed(route); // Clear history for sign out
          } else {
            Get.toNamed(route);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Image.asset(imagePath, height: 20, color: AppColors.primaryRed),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8A98E5), // Support button color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        elevation: 5,
        shadowColor: const Color(0xFF8A98E5).withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Support', style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          Image.asset('assets/imgs/sup.png', height: 24, color: Colors.white),
        ],
      ),
    );
  }
}
