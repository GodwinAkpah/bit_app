import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/notification_model.dart';
import '../../../utils/app_colors.dart';
import '../controller/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // <-- Change icons to white
        title: const Text('Notification', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primaryRed,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // <-- Changed background color to white
        child: Obx(() => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _buildNotificationItem(notification);
          },
        )),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/images/donor1.png')),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
              child: Text(
                notification.bloodType,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        title: Text(notification.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(notification.location, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}