import 'package:get/get.dart';
import '../controller/requests_list_controller.dart';

class RequestListBinding extends Bindings {
  @override
  void dependencies() {
    // The RequestsListController will automatically find the globally registered
    // RequestService, so we only need to register the controller itself.
    Get.lazyPut<RequestsListController>(
      () => RequestsListController(),
    );
  }
}
