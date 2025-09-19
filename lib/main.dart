// import 'package:bit_app/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'app/routes/app_pages.dart';
// import 'app/theme/app_theme.dart';

// void main() {
//   runApp(MyApp( navigatorKey: Get.key));
// }

// class MyApp extends StatelessWidget {
//    final GlobalKey<NavigatorState> navigatorKey;
//   const MyApp({super.key, required this.navigatorKey});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'BloodBit',
//       theme: AppTheme.lightTheme,
//       // Change this to start at the splash screen
//       initialRoute: AppRoutes.SPLASH,
//       getPages: AppPages.routes,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:bit_app/app/routes/app_pages.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/theme/app_theme.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // --- ADD THESE TWO LINES ---
  await GetStorage.init();
  setupServiceLocator();
  // --- END OF ADDITIONS ---

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BloodBit',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}