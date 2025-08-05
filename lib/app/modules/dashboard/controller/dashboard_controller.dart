import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Variable to store the currently selected tab index
  final RxInt tabIndex = 0.obs;

  /// Changes the tab index when a bottom navigation item is tapped.
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}