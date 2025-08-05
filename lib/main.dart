import 'package:bit_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(MyApp( navigatorKey: Get.key));
}

class MyApp extends StatelessWidget {
   final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BloodBit',
      theme: AppTheme.lightTheme,
      // Change this to start at the splash screen
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}