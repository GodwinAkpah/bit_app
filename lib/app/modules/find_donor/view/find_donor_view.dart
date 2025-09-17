import 'package:bit_app/app/modules/donor_profile/models/donor_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/find_donor_controller.dart';

class FindDonorView extends GetView<FindDonorController> {
  const FindDonorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // <-- Change icons to white
        title: const Text('Find Donor', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primaryRed,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[200], // <-- Set background color to grey
        child: Column(
          children: [
            _buildSearchBar(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.center,
                child: Text('Available donors', style: TextStyle(color: Colors.grey)),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.filteredDonors.length,
                itemBuilder: (context, index) {
                  final donor = controller.filteredDonors[index];
                  return _donorListItem(donor);
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: controller.search,
        decoration: InputDecoration(
          hintText: 'Select a blood group or name',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _donorListItem(Donor donor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: () => controller.navigateToDonorProfile(donor),
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(radius: 25, backgroundImage: AssetImage(donor.imageUrl)),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
              child: Text(donor.bloodType, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        title: Text(donor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(donor.phone),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primaryRed, size: 1),
                const SizedBox(width: 4),
                Text(donor.location, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
