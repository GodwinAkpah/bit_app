import 'package:bit_app/app/modules/widgets/custom_textfield.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/imgs/logo_full.png', height: 100),
              const SizedBox(height: 20),
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: controller.emailController,
                labelText: 'Email',
                hintText: 'patient@gmail.com',
              ),
              const SizedBox(height: 20),
              Obx(() => CustomTextField(
                    controller: controller.passwordController,
                    labelText: 'Password',
                    hintText: '********',
                    isPassword: true,
                    isPasswordVisible: controller.isPasswordVisible.value,
                    onVisibilityToggle: controller.togglePasswordVisibility,
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () { /* Placeholder for Forgot Password */ },
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: AppColors.primaryRed)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Login',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 24),
              _buildBiometricLogins(), // Correctly placed biometric widget
              const SizedBox(height: 24),
              const Center(
                  child: Text('or sign-in with:',
                      style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 20),
              _buildSocialLogins(),
              const SizedBox(height: 40),
              _buildRegisterLink(),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Widget for the Biometric Icons (UI only).
  Widget _buildBiometricLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: controller.onBiometricLoginTap,
          icon: const Icon(Icons.fingerprint, color: AppColors.primaryTeal, size: 45),
        ),
        const SizedBox(width: 24),
        IconButton(
          onPressed: controller.onBiometricLoginTap,
          icon: const Icon(Icons.document_scanner_outlined, color: AppColors.primaryTeal, size: 40),
        ),
      ],
    );
  }

  /// Widget for Social Login buttons (UI only).
  Widget _buildSocialLogins() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            text: 'Facebook',
            imagePath: 'assets/imgs/Vector.png', // Add this to assets/images
            onTap: () => controller.onSocialLoginTap('Facebook'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _socialButton(
            text: 'Google',
            imagePath: 'assets/images/Original.png', // Add this to assets/images
            onTap: () => controller.onSocialLoginTap('Google'),
          ),
        ),
      ],
    );
  }

  Widget _socialButton({required String text, required String imagePath, required VoidCallback onTap}) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Image.asset(imagePath, height: 20.0),
      label: Text(text, style: const TextStyle(color: Colors.black54)),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(color: Colors.black54, fontFamily: 'Montserrat'),
          children: [
            TextSpan(
              text: 'Register here',
              style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppRoutes.SIGN_UP),
            ),
          ],
        ),
      ),
    );
  }
}