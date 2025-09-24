
import 'package:bit_app/services/user_service.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // The ProfileController requires a UserService.
    // Get.lazyPut will create the controller when it's first needed.
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<UserService>()),
    );
  }
}
