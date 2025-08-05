import 'package:bit_app/app/modules/home/controller/home_controller.dart';
import 'package:bit_app/app/modules/profile/controller/profile_controller.dart';
import 'package:bit_app/app/modules/requests_list/controller/requests_list_controller.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Dashboard controller to manage tab switching
    Get.lazyPut<DashboardController>(() => DashboardController());
    
    // Controllers for each tab
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    // Get.lazyPut<RequestController>(() => RequestController()); // For the middle tab
    Get.lazyPut<RequestsListController>(() => RequestsListController());
  }
}