import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(icon: Icons.person_outline, text: 'Profile', onTap: () {}),
          _buildDrawerItem(icon: Icons.inbox_outlined, text: 'Inbox', badge: '+10', onTap: () {}),
          _buildDrawerItem(icon: Icons.history, text: 'Request History', onTap: () {}),
          _buildDrawerItem(icon: Icons.history_toggle_off, text: 'Donate History', onTap: () {}),
          _buildDrawerItem(
             icon: Icons.notifications_outlined,
             text: 'Notifications',
              hasDot: true,
            onTap: () {
             Get.back(); // Close the drawer first
           Get.toNamed(AppRoutes.NOTIFICATIONS); // Then navigate
           },
),      
          _buildDrawerItem(icon: Icons.settings_outlined, text: 'Settings', onTap: () {}),
          const Divider(height: 30),
          _buildDrawerItem(icon: Icons.help_outline, text: 'Help', onTap: () {}),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Sign out',
            onTap: () {
              // Clear all routes and go back to login
              Get.offAllNamed(AppRoutes.LOGIN);
            },
          ),
          const SizedBox(height: 20),
          _buildSupportButton(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text('Username', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/user_profile.png'), // Add user profile image
      ),
      decoration: BoxDecoration(color: Colors.white),
      otherAccountsPictures: [],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    String? badge,
    bool hasDot = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Row(
        children: [
          Text(text),
          if (hasDot) const SizedBox(width: 8),
          if (hasDot) Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
          ),
        ],
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(12)),
              child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 12)),
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildSupportButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8A98E5), // Support button color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Support', style: TextStyle(color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.support_agent, color: Colors.white),
          ],
        ),
      ),
    );
  }
}