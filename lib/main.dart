import 'package:bit_app/app/routes/app_pages.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/theme/app_theme.dart';
import 'package:bit_app/services/service_manifest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Ensure that Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await setupServiceLocator();
  final box = GetStorage();
  final token = box.read('auth_token');
  // Determine the initial route based on the token.
  final String initialRoute = (token != null && token.isNotEmpty) ? AppRoutes.DASHBOARD : AppRoutes.SPLASH;
  // --- END ADDED LOGIC ---
  // Pass the initial route to the app.
  runApp(MyApp(initialRoute: initialRoute));
}
class MyApp extends StatelessWidget {
  // --- MODIFIED TO ACCEPT INITIAL ROUTE ---
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BloodBit',
      theme: AppTheme.lightTheme,
      // Use the passed-in initial route.
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
