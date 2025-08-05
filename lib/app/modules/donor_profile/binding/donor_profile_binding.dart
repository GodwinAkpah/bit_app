import 'package:get/get.dart';
import '../controller/donor_profile_controller.dart';

class DonorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonorProfileController>(() => DonorProfileController());
  }
}