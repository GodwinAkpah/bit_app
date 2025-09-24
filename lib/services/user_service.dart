import 'package:bit_app/services/core_service.dart';
import 'package:bit_app/services/models/api_response.dart';

class UserService {
  final CoreService _coreService;
  UserService(this._coreService);

  /// Updates the user's profile data on the server and locally.
  Future<APIResponse> updateProfile(Map<String, dynamic> data) async {
    final userData = _coreService.getStorage.read('user_data');

    if (userData is! Map<String, dynamic> || userData['id'] == null) {
      return APIResponse(status: 'error', message: 'User not found. Cannot update profile.');
    }
    final userId = userData['id'];

    final url = '/users/$userId';

    final response = await _coreService.put(url: url, payload: data);

    if (response.status == 'success' && response.data != null) {
      _coreService.getStorage.write('user_data', response.data);
    }

    return response;
  }

  /// Finds donors based on specified criteria.
  Future<APIResponse> findDonors({
    String? bloodGroup,
    String? location,
    String? name,
  }) async {
    const url = '/donors/';
    
    final Map<String, dynamic> queryParams = {};
    if (bloodGroup != null && bloodGroup.isNotEmpty) {
      queryParams['blood_group'] = bloodGroup;
    }
    if (location != null && location.isNotEmpty) {
      queryParams['location'] = location;
    }
    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }

    // Call the CoreService's get method with the query parameters.
    final response = await _coreService.get(url: url, queryParams: queryParams);

    return response;
  }
}
