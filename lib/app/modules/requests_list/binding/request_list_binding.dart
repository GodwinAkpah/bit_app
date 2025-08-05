import 'package:get/get.dart';
import '../controller/requests_list_controller.dart';

class RequestsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestsListController>(() => RequestsListController());
  }
}