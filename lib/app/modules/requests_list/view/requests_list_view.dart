
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/data/models/blood_request_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import '../controller/requests_list_controller.dart';

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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
          } else if (controller.errorMessage.value.isNotEmpty) {
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
            return const Center(
              child: Text(
                'No blood requests found.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: controller.fetchRequests,
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
              '${request.quantity} pints',
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
        // --- ADDED STATUS CHIP ---
        trailing: _buildStatusChip(request.status),
      ),
    );
  }

  // --- NEW WIDGET TO DISPLAY THE STATUS ---
  Widget _buildStatusChip(String? status) {
    // Default to 'pending' if status is null or empty
    final effectiveStatus = (status == null || status.isEmpty) ? 'pending' : status.toLowerCase();

    Color chipColor;
    String statusText;

    switch (effectiveStatus) {
      case 'accepted':
        chipColor = AppColors.primaryTeal;
        statusText = 'Accepted';
        break;
      case 'pending':
      default: // Catches 'pending' and any other unexpected status
        chipColor = Colors.orange;
        statusText = 'Pending';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: chipColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
