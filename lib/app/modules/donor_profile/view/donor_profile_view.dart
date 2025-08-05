// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart'; // REMOVE THIS IMPORT
// import '../../../utils/app_colors.dart';
// import '../controller/donor_profile_controller.dart';

// class DonorProfileView extends GetView<DonorProfileController> {
//   const DonorProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Donor'),
//         backgroundColor: AppColors.primaryRed,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               _buildProfileHeader(),
//               const SizedBox(height: 20),
//               _buildStatsCard(),
//               const SizedBox(height: 20),
//               _buildActionButtons(),
//               const SizedBox(height: 20),
//               _buildLocationCard(), // This widget is now updated
//             ],
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
//         Text(controller.donor.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 4),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.phone, color: Colors.grey, size: 16),
//             const SizedBox(width: 8),
//             Text(controller.donor.phone, style: const TextStyle(color: Colors.grey, fontSize: 16)),
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // --- UPDATED LOCATION CARD WIDGET ---
//   Widget _buildLocationCard() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.location_on, color: AppColors.primaryRed),
//             const SizedBox(width: 8),
//             Text(controller.donor.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Image.asset(
//             'assets/images/map_placeholder.png', // Using the placeholder image
//             height: 200,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../controller/donor_profile_controller.dart';

class DonorProfileView extends GetView<DonorProfileController> {
  const DonorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Donor'),
        backgroundColor: AppColors.primaryRed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildStatsCard(),
              const SizedBox(height: 20),
              _buildActionButtons(),
              const SizedBox(height: 20),
              _buildLocationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(radius: 40, backgroundImage: AssetImage(controller.donor.imageUrl)),
        const SizedBox(height: 12),
        Text(controller.donor.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: 8),
            Text(controller.donor.phone, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statItem(controller.donor.bloodType, 'Blood Type'),
        _statItem(controller.donor.donated.toString(), 'Donated'),
        _statItem(controller.donor.requested.toString(), 'Requested'),
      ],
    );
  }
  
  Widget _statItem(String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
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
            icon: const Icon(Icons.call, color: Colors.white),
            label: const Text('Call Now', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.requestBlood,
            icon: const Icon(Icons.bloodtype, color: Colors.white),
            label: const Text('Request', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryRed,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            Text(controller.donor.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/map_placeholder.png', // Using the placeholder image
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}