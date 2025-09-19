

// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/request_detail_controller.dart';

// class RequestDetailView extends GetView<RequestDetailController> {
//   const RequestDetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Blood Requests'),
//         backgroundColor: AppColors.primaryRed,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           // --- LOADING STATE ---
//           return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
//         } else if (controller.errorMessage.value.isNotEmpty) {
//           // --- ERROR STATE ---
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Text(controller.errorMessage.value, textAlign: TextAlign.center),
//             ),
//           );
//         } else {
//           // --- SUCCESS STATE ---
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 _buildRequesterCard(),
//                 const SizedBox(height: 20),
//                 _buildReasonCard(),
//                 const SizedBox(height: 20),
//                 _buildLocationCard(),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
//   Widget _buildRequesterCard() {
//   return Obx(() => Container(
//     padding: const EdgeInsets.all(20),
//     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//     child: Column(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage('assets/images/user_placeholder.png'),
//         ),
//         const SizedBox(height: 12),
//         Text(controller.request.value.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         Text(
//           controller.request.value.unitsNeeded,
//           style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         const Divider(height: 30),
//         Row(
//           children: [
//             Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow)),
//             const SizedBox(width: 16),
            
//             // --- THE FIX IS HERE ---
//             // Wrap the "Accept" button in an Obx to make it reactive
//             Expanded(
//               child: Obx(() => ElevatedButton.icon(
//                 // Disable the button when it's loading
//                 onPressed: controller.isAccepting.value ? null : controller.acceptRequest,
//                 icon: controller.isAccepting.value
//                     ? const SizedBox.shrink() // Hide icon when loading
//                     : const Icon(Icons.check_circle, color: Colors.white, size: 20),
//                 label: controller.isAccepting.value
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                       )
//                     : const Text('Accept', style: TextStyle(color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryRed,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ));
// }

//   // Widget _buildRequesterCard() {
//   //   // Use Obx to rebuild this specific widget when request.value changes
//   //   return Obx(() => Container(
//   //     padding: const EdgeInsets.all(20),
//   //     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//   //     child: Column(
//   //       children: [
//   //         CircleAvatar(
//   //           radius: 40,
//   //           backgroundImage: AssetImage('assets/imgs/user_placeholder.png'),
//   //         ),
//   //         const SizedBox(height: 12),
//   //         Text(controller.request.value.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//   //         const SizedBox(height: 8),
//   //         Text(
//   //           controller.request.value.unitsNeeded,
//   //           style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
//   //         ),
//   //         const Divider(height: 30),
//   //         Row(
//   //           children: [
//   //             Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow)),
//   //             const SizedBox(width: 16),
//   //             Expanded(child: _actionButton(text: 'Accept', icon: Icons.check_circle, color: AppColors.primaryRed, onTap: controller.acceptRequest)),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   ));
//   // }

//   Widget _buildReasonCard() {
//     return Obx(() => Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Reason:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(
//             controller.request.value.reason ?? "No reason provided.",
//             style: TextStyle(color: Colors.grey[600], height: 1.4),
//           ),
//         ],
//       ),
//     ));
//   }

//   Widget _buildLocationCard() {
//     return Obx(() => Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.location_on, color: AppColors.primaryRed),
//               const SizedBox(width: 8),
//               Text(controller.request.value.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.asset(
//               'assets/images/map_placeholder.png',
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
//     ));
//   }

//   // Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap}) {
//   //   return ElevatedButton.icon(
//   //     onPressed: onTap,
//   //     icon: Icon(icon, color: Colors.white, size: 20),
//   //     label: Text(text, style: const TextStyle(color: Colors.white)),
//   //     style: ElevatedButton.styleFrom(
//   //       backgroundColor: color,
//   //       padding: const EdgeInsets.symmetric(vertical: 12),
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//   //     ),
//   //   );
//   // }
//   Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap}) {
//   return ElevatedButton.icon(
//     onPressed: onTap,
//     icon: Icon(icon, color: Colors.white, size: 20),
//     label: Text(text, style: const TextStyle(color: Colors.white)),
//     style: ElevatedButton.styleFrom(
//       backgroundColor: color,
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     ),
//   );
// }
// }
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/request_detail_controller.dart';

class RequestDetailView extends GetView<RequestDetailController> {
  const RequestDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Blood Requests'),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Obx(() {
        // --- THE FIX IS HERE ---
        // Changed controller.isLoading.value to controller.isLoadingPage.value
        if (controller.isLoadingPage.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(controller.errorMessage.value, textAlign: TextAlign.center),
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRequesterCard(),
                const SizedBox(height: 20),
                _buildReasonCard(),
                const SizedBox(height: 20),
                _buildLocationCard(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildRequesterCard() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/imgs/por.png'),
          ),
          const SizedBox(height: 12),
          Text(controller.request.value.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            controller.request.value.unitsNeeded,
            style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow)),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() => ElevatedButton.icon(
                  onPressed: controller.isAccepting.value ? null : controller.acceptRequest,
                  icon: controller.isAccepting.value
                      ? const SizedBox.shrink()
                      : const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  label: controller.isAccepting.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Accept', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildReasonCard() {
    return Obx(() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reason:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            controller.request.value.reason ?? "No reason provided.",
            style: TextStyle(color: Colors.grey[600], height: 1.4),
          ),
        ],
      ),
    ));
  }

  Widget _buildLocationCard() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primaryRed),
              const SizedBox(width: 8),
              Text(controller.request.value.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/imgs/map.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Text('Get Directions', style: TextStyle(color: AppColors.primaryRed)),
              label: const Icon(Icons.directions, color: AppColors.primaryRed),
            ),
          )
        ],
      ),
    ));
  }

  Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}