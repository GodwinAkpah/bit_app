import 'package:bit_app/app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:get/get.dart';


class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}