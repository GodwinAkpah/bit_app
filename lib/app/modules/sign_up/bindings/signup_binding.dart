import 'package:bit_app/app/modules/sign_up/controller/signup_controller.dart';
import 'package:get/get.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}