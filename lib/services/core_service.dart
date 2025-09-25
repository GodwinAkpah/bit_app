import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/services/models/api_response.dart';
import 'package:dio/dio.dart' as dio_pack;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class CoreService {
  final _dio = dio_pack.Dio();
  final getStorage = GetStorage();

  CoreService() {
    _dio.options
      ..baseUrl = "https://bloodbit.onrender.com"
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60);
      
    _setupInterceptors();
  }

  /// Handles common Dio errors and formats them into a standard APIResponse.
  APIResponse _handleDioError(dio_pack.DioException e) {
    // Handle specific timeout errors with a user-friendly message.
    if (e.type == dio_pack.DioExceptionType.connectionTimeout || e.type == dio_pack.DioExceptionType.receiveTimeout) {
      return APIResponse(
        status: "error",
        data: null,
        message: "The server is taking too long to respond. Please check your internet connection and try again.",
      );
    }
    
    // Handle structured errors sent from the server (e.g., validation errors).
    if (e.response?.data is Map<String, dynamic>) {
      return APIResponse.fromMap(e.response!.data);
    } 
    
    // Handle other, more generic network errors.
    else {
      return APIResponse(
        status: "error",
        data: null,
        message: e.message ?? "An unexpected network error occurred.",
      );
    }
  }

  /// Sets up Dio interceptors for handling requests, responses, and errors globally.
  void _setupInterceptors() {
    _dio.interceptors.add(
      dio_pack.InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getStorage.read('auth_token');
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }
          print("--> ${options.method.toUpperCase()} ${options.path}");
          print("Headers: ${options.headers}");
          print("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("<-- ${response.statusCode} ${response.requestOptions.path}");
          print("Raw Response Data: ${response.data.toString()}");
          print("<-- END HTTP");
          return handler.next(response);
        },
        onError: (dio_pack.DioException error, handler) {
          print("<!- ERROR ${error.response?.statusCode} ${error.requestOptions.path}");
          print("Error Response Data: ${error.response?.data.toString()}");
          print("<!- END ERROR");
          if (error.response?.statusCode == 401 && Get.currentRoute != AppRoutes.LOGIN) {
            _handleUnauthorizedAccess();
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Clears the user's session and navigates them to the login screen.
  void _handleUnauthorizedAccess() {
    getStorage.remove('auth_token');
    getStorage.remove('user_data');
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  // --- REUSABLE HTTP METHODS ---

 Future<APIResponse> post({required String url, dynamic payload}) async {
    try {
      final res = await _dio.post(url, data: payload);

      if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300) {
        return APIResponse(
          status: 'success',
          message: 'Operation completed successfully.',
          data: res.data,
        );
      }
      
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// For PUT requests (updating data).
  Future<APIResponse> put({required String url, dynamic payload}) async {
    try {
      final res = await _dio.put(url, data: payload);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// For GET requests (fetching data).
  Future<APIResponse> get({required String url, Map<String, dynamic>? queryParams}) async {
    try {
      final res = await _dio.get(url, queryParameters: queryParams);

      if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300) {
        return APIResponse(
          status: 'success',
          message: 'Data fetched successfully.',
          data: res.data,
        );
      }
      
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// For DELETE requests.
  Future<APIResponse> delete({required String url, dynamic payload}) async {
    try {
      final res = await _dio.delete(url, data: payload);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }
}
