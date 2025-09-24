import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/core_service.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:bit_app/services/user_service.dart';
import 'package:get/get.dart';

/// Initializes all the core services of the application.
///
/// This function is responsible for setting up the dependency injection
/// for all the major services. It follows a clear order to ensure that
/// dependencies are available when they are needed.
///
/// The services are registered as `permanent`, meaning they will be kept
/// in memory throughout the lifecycle of the app.
Future<void> setupServiceLocator() async {
  // 1. CoreService is registered first as it has no dependencies.
  Get.put(CoreService(), permanent: true);

  // 2. All other services depend on CoreService. We use Get.find() to
  //    locate the globally registered CoreService and inject it into them.
  Get.put(AuthService(Get.find<CoreService>()), permanent: true);
  Get.put(RequestService(Get.find<CoreService>()), permanent: true);
  Get.put(UserService(Get.find<CoreService>()), permanent: true);
}
