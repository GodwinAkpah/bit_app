// import 'package:bit_app/app/modules/donor_profile/models/donor_model.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart'; // Still needed


// class DonorProfileController extends GetxController {
//   late Donor donor;

//   @override
//   void onInit() {
//     super.onInit();
//     // Receive the donor object passed from the previous screen
//     donor = Get.arguments as Donor;
//   }

//   /// Launches the device's phone dialer with the donor's number.
//   Future<void> callDonor() async {
//     final Uri launchUri = Uri(scheme: 'tel', path: donor.phone);
//     if (await canLaunchUrl(launchUri)) {
//       await launchUrl(launchUri);
//     } else {
//       Get.snackbar('Could not launch call', 'Could not make a phone call to ${donor.phone}');
//     }
//   }

//   /// Shows a confirmation dialog that the request was sent.
//   void requestBlood() {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.check_circle, color: AppColors.primaryRed, size: 50),
//               const SizedBox(height: 16),
//               const Text('Request Sent!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               const Text(
//                 'Your request has been sent. Make sure to contact donor by clicking the call button.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     // Close dialog after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () => Get.back());
//   }
// }
import 'package:bit_app/app/modules/donor_profile/models/donor_model.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';



class DonorProfileController extends GetxController {
  late Donor donor;

  @override
  void onInit() {
    super.onInit();
    donor = Get.arguments as Donor;
  }

  Future<void> callDonor() async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: donor.phone);
    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      Get.snackbar('Action Failed', 'Could not make a phone call to ${donor.phone}.');
    }
  }

  void requestBlood() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: AppColors.primaryRed, size: 50),
              const SizedBox(height: 16),
              const Text('Request Sent!', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Your request has been sent. Make sure to contact donor by clicking the call button.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () => Get.back());
  }
}