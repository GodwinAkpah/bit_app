

import 'package:bit_app/services/core_service.dart';
import 'package:bit_app/services/models/api_response.dart';

class RequestService extends CoreService {
  /// Sends a new blood request to the server.
  /// The endpoint is POST /blood-requests/
  Future<APIResponse> createBloodRequest(Map<String, dynamic> data) async {
    // Note: The endpoint from Postman has a trailing slash.
    // Our CoreService baseUrl does not, so we include it here.
    return await post(url: "/blood-requests/", payload: data);
  }

    /// Fetches a list of blood requests from the server (GET).
  /// Optionally accepts a map of filters.
  Future<APIResponse> getBloodRequests({Map<String, dynamic>? filters}) async {
    return await get(url: "/blood-requests/", params: filters);
  }
}