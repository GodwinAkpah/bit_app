
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import '../controller/find_donor_controller.dart';

class FindDonorView extends GetView<FindDonorController> {
  const FindDonorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Donor', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchAndFilterControls(),
            const SizedBox(height: 16),
            // The list of donors will reactively update based on search/filter
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (controller.filteredDonors.isEmpty) {
                  return const Center(
                    child: Text(
                      'No donors found matching your criteria.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // Display the list of donors
                return ListView.builder(
                  itemCount: controller.filteredDonors.length,
                  itemBuilder: (context, index) {
                    final donor = controller.filteredDonors[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryRed,
                          child: Text(
                            donor.bloodType,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(donor.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(donor.location, style: const TextStyle(color: Colors.grey)),
                        onTap: () => controller.navigateToDonorProfile(donor),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the search bar and blood group dropdown.
  Widget _buildSearchAndFilterControls() {
    return Column(
      children: [
        // --- Search Bar ---
        TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: 'Search by name...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 12),
        // --- Blood Group Filter ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!)
          ),
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedBloodGroup.value,
                  isExpanded: true,
                  icon: const Icon(Icons.bloodtype, color: AppColors.primaryRed),
                  items: controller.bloodGroups.map((String bloodGroup) {
                    return DropdownMenuItem<String>(
                      value: bloodGroup,
                      child: Text(bloodGroup == 'All' ? 'All Blood Types' : bloodGroup),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // The controller handles the filtering logic
                    controller.selectedBloodGroup.value = newValue!;
                  },
                ),
              )),
        ),
      ],
    );
  }
}
