import 'package:bit_app/app/modules/blood_request/binding/blood_request_binding.dart';
import 'package:bit_app/app/modules/blood_request/view/blood_request_view.dart';
import 'package:bit_app/app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:bit_app/app/modules/dashboard/view/dashboard_view.dart';
import 'package:bit_app/app/modules/donor_profile/binding/donor_profile_binding.dart';
import 'package:bit_app/app/modules/donor_profile/view/donor_profile_view.dart';
import 'package:bit_app/app/modules/find_donor/binding/find_donor_binding.dart';
import 'package:bit_app/app/modules/find_donor/view/find_donor_view.dart';
import 'package:bit_app/app/modules/login/bindings/login_binding.dart';
import 'package:bit_app/app/modules/login/view/login_view.dart';
import 'package:bit_app/app/modules/notifications/binding/notifications_binding.dart';
import 'package:bit_app/app/modules/notifications/view/notifications_view.dart';
import 'package:bit_app/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:bit_app/app/modules/onboarding/view/onboarding_view.dart';
import 'package:bit_app/app/modules/profile/binding/profile_binding.dart';
import 'package:bit_app/app/modules/profile/view/profile_view.dart';
import 'package:bit_app/app/modules/request_detail/binding/request_detail_binding.dart';
import 'package:bit_app/app/modules/request_detail/view/request_detail_view.dart';
import 'package:bit_app/app/modules/sign_up/bindings/signup_binding.dart';
import 'package:bit_app/app/modules/sign_up/view/signup_view.dart';
import 'package:bit_app/app/modules/splash/binding/splash_binding.dart';
import 'package:bit_app/app/modules/splash/view/splash_view.dart';
import 'package:bit_app/app/modules/verification/bindings/verification_binding.dart';
import 'package:bit_app/app/modules/verification/view/verififcation_view.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

// ... other imports

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ON_BOARDING,
      page: () => OnBoardingView(), 
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.VERIFICATION,
      page: () => VerificationView(),
      binding: VerificationBinding(),
    ),
  

      // Add the new DASHBOARD route
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),

      GetPage(
      name: AppRoutes.BLOOD_REQUEST,
      page: () => BloodRequestView(),
      binding: BloodRequestBinding(),
      transition: Transition.rightToLeft, // Optional nice transition
    ),

      GetPage(
      name: AppRoutes.FIND_DONOR,
      page: () => FindDonorView(),
      binding: FindDonorBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DONOR_PROFILE,
      page: () => DonorProfileView(),
      binding: DonorProfileBinding(),
      transition: Transition.rightToLeft,
    ),

      GetPage(
      name: AppRoutes.REQUEST_DETAIL,
      page: () =>  RequestDetailView(),
      binding: RequestDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}