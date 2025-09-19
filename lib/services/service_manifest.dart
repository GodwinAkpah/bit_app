import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/request_service.dart';
import 'package:get_it/get_it.dart';

// Import other services like DonorService here when you create them

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  // serviceLocator.registerLazySingleton<DonorService>(() => DonorService());
  serviceLocator.registerLazySingleton<RequestService>(() => RequestService());
}