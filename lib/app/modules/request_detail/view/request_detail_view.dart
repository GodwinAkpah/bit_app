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
      // The main Obx wrapper handles all reactive updates for the view.
      body: Obx(() {
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

  // No Obx needed here, as the parent is already an Obx.
  Widget _buildRequesterCard() {
    return Container(
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
            '${controller.request.value.quantity} pints needed',
            style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow)),
              const SizedBox(width: 16),
              Expanded(
                // A nested Obx here is fine because it rebuilds a small part of the UI (the button state)
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
    );
  }

  // No Obx needed here.
  Widget _buildReasonCard() {
    return Container(
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
    );
  }

  // No Obx needed here.
  Widget _buildLocationCard() {
    return Container(
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
    );
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
