// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/app_colors.dart';
// import '../controller/donor_profile_controller.dart';

// class DonorProfileView extends GetView<DonorProfileController> {
//   const DonorProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Donor', style: TextStyle(color: Colors.white),),
//         backgroundColor: AppColors.primaryRed,
//       ),
//       body: Container(
//         color: Colors.grey[200], // <-- Set background color to grey

//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 _buildProfileHeader(),
//                 const SizedBox(height: 20),
//                 _buildStatsCard(),
//                 const SizedBox(height: 20),
//                 _buildActionButtons(),
//                 const SizedBox(height: 20),
//                 _buildLocationCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Column(
//       children: [
//         CircleAvatar(radius: 40, backgroundImage: AssetImage(controller.donor.imageUrl)),
//         const SizedBox(height: 12),
//         Text(controller.donor.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 4),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.phone, color: Colors.grey, size: 16),
//             const SizedBox(width: 8),
//             Text(controller.donor.phone, style: const TextStyle(color: Colors.grey, fontSize: 14)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsCard() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _statItem(controller.donor.bloodType, 'Blood Type'),
//         _statItem(controller.donor.donated.toString(), 'Donated'),
//         _statItem(controller.donor.requested.toString(), 'Requested'),
//       ],
//     );
//   }
  
//   Widget _statItem(String value, String label) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
//       ),
//       child: Column(
//         children: [
//           Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 4),
//           Text(label, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton.icon(
//             onPressed: controller.callDonor,
//             icon: const Icon(Icons.call, color: Colors.white),
//             label: const Text('Call Now', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryTeal,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: ElevatedButton.icon(
//             onPressed: controller.requestBlood,
//             icon: const Icon(Icons.bloodtype, color: Colors.white),
//             label: const Text('Request', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryRed,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLocationCard() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.location_on, color: AppColors.primaryRed),
//             const SizedBox(width: 8),
//             Text(controller.donor.location, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Image.asset(
//             'assets/imgs/map.png', // Using the placeholder image
//             height: 200,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:bit_app/app/utils/app_colors.dart'; // Make sure path is correct
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/donor_profile_controller.dart';

class DonorProfileView extends GetView<DonorProfileController> {
  const DonorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the radius for the CircleAvatar to use it for positioning calculations.
    const double avatarRadius = 50.0;

    return Scaffold(
      backgroundColor: Colors.white, // Light grey background for the whole screen
      appBar: AppBar(
        title: const Text('Find Donor' , style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryRed,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          // Use a Stack to allow the profile picture to float on top of the content card.
          clipBehavior: Clip.none, // Allow widgets to draw outside the Stack's bounds
          alignment: Alignment.topCenter,
          children: [
            // This is the main white content card.
            // We add a large margin at the top to create space for the floating avatar.
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

            // This is the floating profile picture.
            Positioned(
              // It's positioned at the top of the Stack, which makes it
              // appear at the top of the content card's margin area.
              top: 0,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: AssetImage(controller.donor.imageUrl),
                // Add a border to make it pop
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- REWRITTEN HELPER WIDGETS TO MATCH THE NEW DESIGN ---

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Name is now uppercase and bold
        Text(
          controller.donor.name.toUpperCase(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: 8),
            Text(
              controller.donor.phone,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statItem(controller.donor.bloodType, 'Blood Type'),
        const SizedBox(width: 4), // <-- Add space between items
        _statItem(controller.donor.donated.toString(), 'Donated'),
        const SizedBox(width: 4), // <-- Add space between items
        _statItem(controller.donor.requested.toString(), 'Requested'),
      ],
    );
  }
  
  Widget _statItem(String value, String label) {
    return Container(
      width: (Get.width - 48 - 32-24) / 3, // Responsive width
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        // Use a very light grey to distinguish from the white background
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

    
 
  // THE FIX: Button styles updated to be fully rounded and use custom images.
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

  // This is no longer a separate card, but a section within the main container.
  Widget _buildLocationCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primaryRed),
            const SizedBox(width: 8),
            Text(controller.donor.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/imgs/map.png', // Using the placeholder image
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}