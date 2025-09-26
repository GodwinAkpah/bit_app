
import 'package:bit_app/services/core_service.dart';
import '../models/api_response.dart';

class AuthService {
  final CoreService _coreService;
  AuthService(this._coreService);

  /// Sends registration data to the /auth/register endpoint.
  Future<APIResponse> register(Map<String, dynamic> data) async {
    return await _coreService.post(url: "/auth/register", payload: data);
  }

  /// Sends login credentials to the /auth/login endpoint.
  Future<APIResponse> login(Map<String, dynamic> data) async {
    return await _coreService.post(url: "/auth/login", payload: data);
  }
  
  /// Sends OTP data to the /auth/verify-otp endpoint for verification.
  Future<APIResponse> verifyOtp(Map<String, dynamic> data) async {
    return await _coreService.post(url: "/auth/verify-otp", payload: data);
  }
  
  /// Sends a request to resend the OTP to the user.
  Future<APIResponse> resendOtp(Map<String, dynamic> data) async {
    return await _coreService.post(url: "/auth/resend-otp", payload: data);
  }

  /// Fetches the current logged-in user's profile data.
  Future<APIResponse> getMe() async {
    final userData = _coreService.getStorage.read('user_data');
    if (userData is! Map<String, dynamic> || userData['id'] == null) {
      return APIResponse(status: 'error', message: 'User not found. Cannot fetch profile.');
    }
    final userId = userData['id'];
    return await _coreService.get(url: "/users/$userId");
  }

  Future<APIResponse> forgotPassword(String email) async {
    return await _coreService.post(url: "/auth/forgot-password", payload: {"email": email});
  }
}
