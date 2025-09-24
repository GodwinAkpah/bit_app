import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/donor_profile_controller.dart';

class DonorProfileView extends GetView<DonorProfileController> {
  const DonorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 50.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Donor Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: avatarRadius, left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.fromLTRB(24, avatarRadius + 20, 24, 24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 24),
                  _buildStatsCard(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  _buildLocationCard(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.primaryRed,
                child: const Icon(Icons.person, color: Colors.white, size: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Text(
          controller.user.fullName.toUpperCase(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: 8),
            Text(
              controller.user.phone,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return _statItem(controller.user.bloodGroup, 'Blood Type');
  }

  Widget _statItem(String value, String label) {
    // This widget now takes up a more reasonable width since it's the only one.
    return Container(
      width: Get.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.callDonor,
            icon: Image.asset('assets/imgs/icon.png', height: 20, color: AppColors.primaryTeal),
            label: const Text('Call Now', style: TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.requestBlood,
            icon: Image.asset('assets/imgs/icon.png', height: 20, color: Colors.white),
            label: const Text('Request', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryRed,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primaryRed),
            const SizedBox(width: 8),
            Text(controller.user.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/imgs/map.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
