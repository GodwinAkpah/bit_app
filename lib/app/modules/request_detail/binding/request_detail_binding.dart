import 'package:get/get.dart';
import '../controller/request_detail_controller.dart';

class RequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestDetailController>(() => RequestDetailController());
  }
}