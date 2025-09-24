import 'package:bit_app/services/models/api_response.dart';
import 'package:bit_app/services/core_service.dart';

class RequestService {
  final CoreService _coreService;
  RequestService(this._coreService);

  /// Sends a new blood request to the server.
  /// The endpoint is POST /blood-requests/
  Future<APIResponse> createBloodRequest(Map<String, dynamic> data) async {
    return await _coreService.post(url: "/blood-requests/", payload: data);
  }

  /// Fetches a list of blood requests from the server (GET).
  /// Optionally accepts a map of filters.
  Future<APIResponse> getBloodRequests({Map<String, dynamic>? filters}) async {
    return await _coreService.get(url: "/blood-requests/", queryParams: filters);
  }

  /// Fetches a single blood request by its ID.
  Future<APIResponse> getBloodRequestById(String requestId) async {
    return await _coreService.get(url: "/blood-requests/$requestId/");
  }

  /// Accepts a blood request by updating its status.
  Future<APIResponse> acceptBloodRequest({
    required String requestId,
    required Map<String, dynamic> data,
  }) async {
    return await _coreService.put(url: "/blood-requests/$requestId/", payload: data);
  }
}
