import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../controller/request_detail_controller.dart';

class RequestDetailView extends GetView<RequestDetailController> {
  const RequestDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Requests' , style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Container(
        color: Colors.grey[200], // <-- Set background color to grey
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  Widget _buildRequesterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/imgs/por.png'), // Add a placeholder
          ),
          const SizedBox(height: 12),
          Text(controller.request.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Needs ${controller.request.unitsNeeded} Units',
            style: const TextStyle(color: AppColors.primaryTeal, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(text: 'Call Now', icon: Icons.call, color: AppColors.primaryTeal, onTap: controller.callNow, borderRadius: 30, )),
              const SizedBox(width: 16),
              Expanded(child: _actionButton(text: 'Accept', icon: Icons.check_circle, color: AppColors.primaryRed, onTap: controller.acceptRequest,borderRadius: 30, )),
            ],
          ),
        ],
      ),
    );
  }

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
          Text(controller.request.reason, style: TextStyle(color: Colors.grey[600], height: 1.4)),
        ],
      ),
    );
  }

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
              Text(controller.request.location, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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

  Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap, double borderRadius = 30, }) {
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