import 'package:bit_app/app/modules/verification/controller/verification_controller.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';


class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the pinput theme here for reuse
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[400]!, width: 2)),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeaderIcon(),
            const SizedBox(height: 40),
            const Text(
              'OTP Verification',
              style: TextStyle(fontSize: 24,     fontWeight: FontWeight.w600,),
            ),
            const SizedBox(height: 16),
            Obx(() => controller.isOtpSent.value
                ? _buildEnterOtpText()
                : _buildInitialText()),
            const SizedBox(height: 40),
            Obx(() => controller.isOtpSent.value
                ? _buildOtpInput(defaultPinTheme)
                : _buildConfirmNumber()),
            const SizedBox(height: 40),
            Obx(() => controller.isOtpSent.value
                ? _buildVerifyButton()
                : _buildSendOtpButton()),
            const SizedBox(height: 20),
            Obx(() =>
                controller.isOtpSent.value ? _buildResendLink() : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: AppColors.primaryRed.withOpacity(0.1),
      // ),
      child: Image.asset(
        'assets/imgs/port.png', // Update the path as needed
        width: 180,
        height: 180,
        // color: AppColors.primaryRed, // Optional: tint the image
      ),
    );
  }

  Widget _buildInitialText() {
    return const Text(
      'We will send you a one-time password\nto this mobile number',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  Widget _buildEnterOtpText() {
    return Text.rich(
      TextSpan(
        text: 'Enter OTP sent to ',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
        children: [
          TextSpan(
            text: controller.maskedPhoneNumber,
            style: const TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildConfirmNumber() {
    return Column(
      children: [
        const Text(
          'Confirm mobile number',
          style: TextStyle(fontSize: 1, color: AppColors.primaryTeal),
        ),
        const SizedBox(height: 8),
        Text(
          controller.maskedPhoneNumber,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildOtpInput(PinTheme defaultPinTheme) {
    return Pinput(
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: const Border(bottom: BorderSide(color: AppColors.primaryRed, width: 2)),
        ),
      ),
      onCompleted: (pin) => controller.verifyOtp(pin),
    );
  }

  Widget _buildSendOtpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.sendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Send OTP', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // Button is slightly faded like in the design
        onPressed: () {}, // Verification is triggered by onCompleted in Pinput
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Verify & Proceed', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildResendLink() {
    return Obx(() => Text.rich(
      TextSpan(
        text: "Didn't receive the OTP? ",
        style: const TextStyle(color: Colors.grey),
        children: [
          if (controller.resendTimer.value > 0)
            TextSpan(
              text: 'Resend in ${controller.resendTimer.value}s',
              style: const TextStyle(color: Colors.grey),
            )
          else
            TextSpan(
              text: 'Resend OTP',
              style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = () => controller.resendOtp(),
            ),
        ],
      ),
    ));
  }
}