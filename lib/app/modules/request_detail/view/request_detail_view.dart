// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/app_colors.dart';
// import '../controller/request_detail_controller.dart';

// class RequestDetailView extends GetView<RequestDetailController> {
//   const RequestDetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Blood Requests' , style: TextStyle(color: Colors.white),),
//         backgroundColor: AppColors.primaryRed,
//       ),
//       body: Container(
//         color: Colors.grey[200], // <-- Set background color to grey
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               _buildRequesterCard(),
//               const SizedBox(height: 20),
//               _buildReasonCard(),
//               const SizedBox(height: 20),
//               _buildLocationCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRequesterCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundImage: AssetImage('assets/imgs/por.png'), // Add a placeholder
//           ),
//           const SizedBox(height: 12),
//           Text(controller.request.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(
//             'Needs ${controller.request.unitsNeeded} Units',
//             style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const Divider(height: 30),
//           Row(
//             children: [
//               Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow, borderRadius: 30, )),
//               const SizedBox(width: 16),
//               Expanded(child: _actionButton(text: 'Accept', icon: Icons.check_circle, color: AppColors.primaryRed, onTap: controller.acceptRequest,borderRadius: 30, )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReasonCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Reason:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(controller.request.reason, style: TextStyle(color: Colors.grey[600], height: 1.4)),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocationCard() {
//     return Container(
//        padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.location_on, color: AppColors.primaryRed),
//               const SizedBox(width: 8),
//               Text(controller.request.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.asset(
//               'assets/imgs/map.png',
//               height: 180,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton.icon(
//               onPressed: () {},
//               icon: const Text('Get Directions', style: TextStyle(color: AppColors.primaryRed)),
//               label: const Icon(Icons.directions, color: AppColors.primaryRed),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap, double borderRadius = 30, }) {
//     return ElevatedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, color: Colors.white, size: 20),
//       label: Text(text, style: const TextStyle(color: Colors.white)),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }
// }
import 'package:bit_app/app/modules/requests_list/controller/requests_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/data/models/blood_request_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';


class RequestsListView extends GetView<RequestsListController> {
  const RequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Requests', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey[100],
        // Use Obx to rebuild the body based on the controller's state
        child: Obx(() {
          if (controller.isLoading.value) {
            // --- LOADING STATE ---
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
          } else if (controller.errorMessage.value.isNotEmpty) {
            // --- ERROR STATE ---
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          } else if (controller.requests.isEmpty) {
            // --- EMPTY STATE ---
            return const Center(
              child: Text(
                'No blood requests found.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          } else {
            // --- SUCCESS STATE (LIST) ---
            return RefreshIndicator(
              onRefresh: controller.fetchRequests, // Allows pull-to-refresh
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.requests.length,
                itemBuilder: (context, index) {
                  final request = controller.requests[index];
                  return _buildRequestItem(request);
                },
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildRequestItem(BloodRequestModel request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      child: ListTile(
        onTap: () => controller.viewRequestDetails(request),
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              request.bloodType,
              style: const TextStyle(
                color: AppColors.primaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(request.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              request.unitsNeeded, // Use the getter from the model
              style: const TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(request.location, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}