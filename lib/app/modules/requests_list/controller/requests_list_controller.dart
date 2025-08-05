import 'package:get/get.dart';
import '../../../data/models/blood_request_model.dart';
import '../../../routes/app_routes.dart';

class RequestsListController extends GetxController {
  // Mock data. In a real app, this comes from an API.
  final RxList<BloodRequestModel> requests = <BloodRequestModel>[
    BloodRequestModel(id: '1', name: 'James Davou', location: 'TUDUN WADA, PLATEAU', bloodType: 'O-', unitsNeeded: 3, phone: '08012345678', reason: 'Patient has sickle cells anemia, she requires blood transfusion on regular basis to stay healthy and look. Your blood donation will help her be what she loves.'),
    BloodRequestModel(id: '2', name: 'Veirat Davou', location: 'TUDUN WADA, PLATEAU', bloodType: 'AB+', unitsNeeded: 5, phone: '08012345678', reason: 'Emergency surgery requirement.'),
    BloodRequestModel(id: '3', name: 'King David', location: 'TUDUN WADA, PLATEAU', bloodType: 'B-', unitsNeeded: 5, phone: '08012345678', reason: 'Post-accident trauma care.'),
    BloodRequestModel(id: '4', name: 'Christian Simons', location: 'TUDUN WADA, PLATEAU', bloodType: 'O+', unitsNeeded: 1, phone: '08012345678', reason: 'Scheduled operation.'),
    BloodRequestModel(id: '5', name: 'Elizabeth Mark', location: 'TUDUN WADA, PLATEAU', bloodType: 'B+', unitsNeeded: 6, phone: '08012345678', reason: 'Treatment for a chronic condition.'),
  ].obs;

  /// Navigates to the detail page for a specific request.
  void viewRequestDetails(BloodRequestModel request) {
    Get.toNamed(AppRoutes.REQUEST_DETAIL, arguments: request);
  }
}