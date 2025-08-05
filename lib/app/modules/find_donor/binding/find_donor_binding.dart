import 'package:get/get.dart';
import '../controller/find_donor_controller.dart';

class FindDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindDonorController>(() => FindDonorController());
  }
}