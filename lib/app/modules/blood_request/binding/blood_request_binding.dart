import 'package:bit_app/app/modules/blood_request/controller/blood_request_controller.dart';
import 'package:get/get.dart';


class BloodRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodRequestController>(() => BloodRequestController());
  }
}