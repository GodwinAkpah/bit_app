import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/blood_request_model.dart';
import '../../../utils/app_colors.dart';
import '../controller/requests_list_controller.dart';

class RequestsListView extends GetView<RequestsListController> {
  const RequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Requests' , style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryRed,
        automaticallyImplyLeading: false, // Remove back button from tab view
      ),
      body: Container(
        color: Colors.grey[200], // <-- Set background color to grey
        child: Obx(() => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.requests.length,
          itemBuilder: (context, index) {
            final request = controller.requests[index];
            return _buildRequestItem(request);
          },
        )),
      ),
    );
  }

  Widget _buildRequestItem(BloodRequestModel request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () => controller.viewRequestDetails(request),
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
          child: Text(
            request.bloodType,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(request.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Needs ${request.unitsNeeded} Units', style: const TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.w500)),
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