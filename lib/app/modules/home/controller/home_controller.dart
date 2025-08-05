import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController bannerController = PageController();

  // Function to open the drawer
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  void onClose() {
    bannerController.dispose();
    super.onClose();
  }
}