// import 'package:bit_app/app/modules/sign_up/controller/signup_controller.dart';
// import 'package:bit_app/app/modules/widgets/custom_textfield.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class SignUpView extends GetView<SignUpController> {
//   const SignUpView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightGray,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Image.asset('assets/imgs/logo_full.png', height: 100),
//               const SizedBox(height: 20),
//               const Text(
//                 'Welcome',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(controller: controller.fullNameController, labelText: 'Full Name', hintText: 'Your full name'),
//               const SizedBox(height: 16),
//               CustomTextField(controller: controller.phoneController, labelText: 'Phone Number', hintText: '08012345678'),
//               const SizedBox(height: 16),
//               CustomTextField(controller: controller.emailController, labelText: 'Email', hintText: 'patient@gmail.com'),
//               const SizedBox(height: 16),
//               _buildBloodGroupSelector(),
//               const SizedBox(height: 16),
//               Obx(() => CustomTextField(
//                 controller: controller.passwordController,
//                 labelText: 'Password',
//                 hintText: '********',
//                 isPassword: true,
//                 isPasswordVisible: controller.isPasswordVisible.value,
//                 onVisibilityToggle: controller.togglePasswordVisibility,
//               )),
//               const SizedBox(height: 16),
//               Obx(() => CustomTextField(
//                 controller: controller.confirmPasswordController,
//                 labelText: 'Confirm Password',
//                 hintText: '********',
//                 isPassword: true,
//                 isPasswordVisible: controller.isConfirmPasswordVisible.value,
//                 onVisibilityToggle: controller.toggleConfirmPasswordVisibility,
//               )),
//               const SizedBox(height: 20),
//               _buildTermsAndConditions(),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: controller.registerUser,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryRed,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text('Register', style: TextStyle(fontSize: 18, color: Colors.white)),
//               ),
//               const SizedBox(height: 20),
//               _buildSignInLink(),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBloodGroupSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Bloodgroup', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w500)),
//         const SizedBox(height: 4),
//         Obx(() => InputDecorator(
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//             enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
//             focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryRed)),
//           ),
//           child: Text(
//             controller.selectedBloodGroup.value.isEmpty ? 'Tap to select' : controller.selectedBloodGroup.value,
//             style: TextStyle(
//               color: controller.selectedBloodGroup.value.isEmpty ? Colors.grey[400] : Colors.black,
//               fontSize: 16,
//             ),
//           ),
//         )),
//         const SizedBox(height: 8),
//         Obx(() => Wrap(
//           spacing: 8.0,
//           runSpacing: 8.0,
//           children: controller.bloodGroups.map((group) {
//             final isSelected = controller.selectedBloodGroup.value == group;
//             return ChoiceChip(
//               label: Text(group),
//               selected: isSelected,
//               onSelected: (selected) {
//                 if (selected) {
//                   controller.selectBloodGroup(group);
//                 }
//               },
//               selectedColor: AppColors.primaryRed,
//               labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: BorderSide(color: isSelected ? AppColors.primaryRed : Colors.grey[300]!),
//               ),
//             );
//           }).toList(),
//         )),
//       ],
//     );
//   }

//   Widget _buildTermsAndConditions() {
//     return Obx(() => Row(
//       children: [
//         Checkbox(
//           value: controller.termsAccepted.value,
//           onChanged: (val) => controller.termsAccepted.value = val!,
//           activeColor: AppColors.primaryRed,
//         ),
//         const Expanded(
//           child: Text(
//             'By Creating An Account, You Agree To Our Terms And Condition',
//             style: TextStyle(fontSize: 12),
//           ),
//         ),
//       ],
//     ));
//   }

//   Widget _buildSignInLink() {
//     return Center(
//       child: RichText(
//         text: TextSpan(
//           text: 'Have an account? ',
//           style: const TextStyle(color: Colors.black54, fontFamily: 'Montserrat'),
//           children: [
//             TextSpan(
//               text: 'Sign In',
//               style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
//               recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:bit_app/app/modules/sign_up/controller/signup_controller.dart';
import 'package:bit_app/app/modules/widgets/custom_textfield.dart';
import 'package:bit_app/app/routes/app_routes.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
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
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              CustomTextField(controller: controller.fullNameController, labelText: 'Full Name', hintText: 'Your full name'),
              const SizedBox(height: 16),
              
              CustomTextField(controller: controller.emailController, labelText: 'Email', hintText: 'patient@gmail.com'),
              const SizedBox(height: 16),

              CustomTextField(controller: controller.locationController, labelText: 'Location', hintText: 'City, Country', ),
              const SizedBox(height: 16),
              _buildGenderSelector(),
              const SizedBox(height: 16),

              _buildBloodGroupSelector(),
              const SizedBox(height: 16),
              
              Obx(() => CustomTextField(
                controller: controller.passwordController,
                labelText: 'Password',
                hintText: '********',
                isPassword: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onVisibilityToggle: controller.togglePasswordVisibility,
              )),
              const SizedBox(height: 16),
              
              Obx(() => CustomTextField(
                controller: controller.confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: '********',
                isPassword: true,
                isPasswordVisible: controller.isConfirmPasswordVisible.value,
                onVisibilityToggle: controller.toggleConfirmPasswordVisibility,
              )),
              const SizedBox(height: 20),
              
              _buildTermsAndConditions(),
              const SizedBox(height: 20),
              
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Register', style: TextStyle(fontSize: 18, color: Colors.white)),
              )),
              const SizedBox(height: 20),
              
              _buildSignInLink(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- CORRECTED WIDGET METHOD FOR GENDER SELECTION ---
  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Obx(() => Row(
          children: controller.genders.map((gender) {
            final isSelected = controller.selectedGender.value == gender;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(gender),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) controller.selectGender(gender);
                },
                selectedColor: AppColors.primaryRed,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: isSelected ? AppColors.primaryRed : Colors.grey[300]!),
                ),
                showCheckmark: false,
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildBloodGroupSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bloodgroup', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Obx(() => Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: controller.bloodGroups.map((group) {
            final isSelected = controller.selectedBloodGroup.value == group;
            return ChoiceChip(
              label: Text(group),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  controller.selectBloodGroup(group);
                }
              },
              selectedColor: AppColors.primaryRed,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? AppColors.primaryRed : Colors.grey[300]!),
              ),
              showCheckmark: false,
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Obx(() => Row(
      children: [
        Checkbox(
          value: controller.termsAccepted.value,
          onChanged: (val) => controller.termsAccepted.value = val!,
          activeColor: AppColors.primaryRed,
        ),
        const Expanded(
          child: Text(
            'By Creating An Account, You Agree To Our Terms And Condition',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ));
  }

  Widget _buildSignInLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Have an account? ',
          style: const TextStyle(color: Colors.black54, fontFamily: 'Montserrat'),
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}