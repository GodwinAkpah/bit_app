// THE FIX: Added the essential Flutter Material import.
import 'package:flutter/material.dart'; 
import 'package:bit_app/app/utils/app_colors.dart'; // Make sure this path is correct

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool isPassword;
  final VoidCallback? onVisibilityToggle;
  final bool isPasswordVisible;
  final bool hasCheckmark;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.isPassword = false,
    this.onVisibilityToggle,
    this.isPasswordVisible = false,
    this.hasCheckmark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // This line will no longer have an error.
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: AppColors.primaryRed,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword && !isPasswordVisible,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : (hasCheckmark ? const Icon(Icons.check, color: AppColors.primaryTeal) : null),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryRed),
            ),
          ),
        ),
      ],
    );
  }
}