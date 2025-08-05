import 'package:bit_app/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:bit_app/app/modules/home/view/home_view.dart';
import 'package:bit_app/app/modules/profile/view/profile_view.dart';
import 'package:bit_app/app/modules/requests_list/view/requests_list_view.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
const DashboardView({super.key});
@override
Widget build(BuildContext context) {
return Scaffold(
body: Obx(() => IndexedStack(
index: controller.tabIndex.value,
children: const [
HomeView(),
RequestsListView(),// Placeholder
ProfileView(), // Placeholder for now
],
)),
bottomNavigationBar: Obx(() => BottomNavigationBar(
currentIndex: controller.tabIndex.value,
onTap: controller.changeTabIndex,
selectedItemColor: AppColors.primaryRed,
unselectedItemColor: Colors.grey,
showUnselectedLabels: true,
items: const [
BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
BottomNavigationBarItem(icon: Icon(Icons.bloodtype_outlined), activeIcon: Icon(Icons.bloodtype), label: 'Request'),
BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
],
)),
);
}
}