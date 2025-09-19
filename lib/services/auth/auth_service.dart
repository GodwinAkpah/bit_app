
import 'package:bit_app/services/core_service.dart';

import '../models/api_response.dart';

class AuthService extends CoreService {

  /// Sends registration data to the /auth/register endpoint.
  Future<APIResponse> register(Map<String, dynamic> data) async {
    return await post(url: "/auth/register", payload: data);
  }

  /// Sends login credentials to the /auth/login endpoint.
  Future<APIResponse> login(Map<String, dynamic> data) async {
    return await post(url: "/auth/login", payload: data);
  }
  
  /// Sends OTP data to the /auth/verify-otp endpoint for verification.
  Future<APIResponse> verifyOtp(Map<String, dynamic> data) async {
    return await post(url: "/auth/verify-otp", payload: data);
  }
  
  /// Sends a request to resend the OTP to the user.
  Future<APIResponse> resendOtp(Map<String, dynamic> data) async {
    // This endpoint might be different, e.g., /auth/resend-otp
    return await post(url: "/auth/resend-otp", payload: data);
  }

  /// Fetches the current logged-in user's profile data.
  Future<APIResponse> getMe() async {
    return await get(url: "/user/profile");
  }

  // You can continue adding other specific service methods here,
  // for example:
  // Future<APIResponse> forgotPassword(Map<String, dynamic> data) async {
  //   return await post(url: "/auth/forgot-password", payload: data);
  // }
}