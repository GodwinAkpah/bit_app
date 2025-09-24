import 'package:get/get.dart';
import 'package:bit_app/services/user_service.dart';
import '../controller/find_donor_controller.dart';

class FindDonorBinding extends Bindings {
  @override
  void dependencies() {
    // The UserService is already registered globally in the service_manifest.dart.
    // We just need to register the controller for this specific feature.
    // Get.find<UserService>() will locate the globally registered instance.
    Get.lazyPut<FindDonorController>(
      () => FindDonorController(Get.find<UserService>()),
    );
  }
}
