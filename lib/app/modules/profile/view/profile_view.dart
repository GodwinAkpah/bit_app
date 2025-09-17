// import 'package:bit_app/app/modules/profile/controller/profile_controller.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class ProfileView extends GetView<ProfileController> {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // The Obx widget makes the entire Scaffold reactive to changes in isEditMode.
//     return Obx(() => Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         // Conditionally show a close button in edit mode, or nothing in view mode
//         // (the back button is handled by the navigation stack if needed).
//         leading: controller.isEditMode.value
//             ? IconButton(
//                 icon: const Icon(Icons.close, color: Colors.black),
//                 onPressed: controller.toggleEditMode,
//               )
//             : null,
//         automaticallyImplyLeading: false, // We handle our own leading icon
//         title: Text(
//           controller.isEditMode.value ? 'Edit Profile' : 'Profile',
//           style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           // Show an edit button only when in view mode.
//           if (!controller.isEditMode.value)
//             IconButton(
//               icon: const Icon(Icons.edit_outlined, color: Colors.black),
//               onPressed: controller.toggleEditMode,
//             ),
//         ],
//       ),
//       // Conditionally render the body based on the mode.
//       body: controller.isEditMode.value
//           ? _buildEditProfileForm()
//           : _buildProfileDisplay(),
//     ));
//   }

//   /// Builds the main profile display widget.
//   Widget _buildProfileDisplay() {
//     // Listen to the user object for changes.
//     final user = controller.user.value;
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundImage: AssetImage('assets/images/user_profile.png'),
//           ),
//           const SizedBox(height: 16),
//           Text(user.username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.location_on, size: 16, color: Colors.grey),
//               const SizedBox(width: 4),
//               Text(user.location, style: const TextStyle(color: Colors.grey, fontSize: 16)),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _statItem(user.bloodType, 'Blood Type'),
//               _statItem(user.donated.toString(), 'Donated'),
//               _statItem(user.requested.toString(), 'Requested'),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(child: _actionButton(text: 'Donate', icon: Icons.volunteer_activism, color: AppColors.primaryRed, onTap: () {})),
//               const SizedBox(width: 16),
//               Expanded(child: _actionButton(text: 'Request', icon: Icons.bloodtype, color: AppColors.primaryRed, onTap: () {})),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildAvailabilityToggle(),
//           const SizedBox(height: 16),
//           _actionButton(text: 'Support', icon: Icons.support_agent, color: const Color(0xFF8A98E5), onTap: () {}),
//           const SizedBox(height: 16),
//           TextButton.icon(
//             onPressed: controller.signOut,
//             icon: const Icon(Icons.logout, color: AppColors.primaryRed),
//             label: const Text('Sign out', style: TextStyle(color: AppColors.primaryRed)),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   /// Builds the form for editing the profile.
//   Widget _buildEditProfileForm() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         children: [
//           _buildProfileField('Username', controller.usernameController),
//           _buildProfileField('Email', controller.emailController),
//           _buildProfileField('Phone', controller.phoneController),
//           _buildProfileField('Date Of Birth', controller.dobController),
//           _buildProfileField('Gender', controller.genderController),
//           _buildProfileField('Location', controller.locationController),
//           const SizedBox(height: 30),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: controller.saveProfile,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryRed,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // --- Reusable Helper Widgets ---

//   Widget _statItem(String value, String label) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
//       ),
//       child: Column(
//         children: [
//           Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 4),
//           Text(label, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _actionButton({required String text, required IconData icon, required Color color, required VoidCallback onTap}) {
//     return ElevatedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, color: Colors.white),
//       label: Text(text, style: const TextStyle(color: Colors.white)),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }

//   Widget _buildAvailabilityToggle() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Available for donate', style: TextStyle(fontWeight: FontWeight.w500)),
//           Obx(() => Switch(
//             value: controller.user.value.isAvailable,
//             onChanged: controller.toggleAvailability,
//             activeColor: AppColors.primaryRed,
//           )),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileField(String label, TextEditingController textController) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w500)),
//           TextField(
//             controller: textController,
//             decoration: const InputDecoration(
//               isDense: true,
//               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryRed)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bit_app/app/utils/app_colors.dart'; // Make sure path is correct
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: controller.isEditMode.value
            ? IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: controller.toggleEditMode,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
        title: Text(
          'Profile',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (!controller.isEditMode.value)
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.black),
              onPressed: controller.toggleEditMode,
            ),
        ],
      ),
      body: controller.isEditMode.value
          ? _buildEditProfileForm()
          : _buildProfileDisplay(),
    ));
  }

  Widget _buildProfileDisplay() {
    final user = controller.user.value;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/imgs/por.png'),
          ),
          const SizedBox(height: 16),
          Text(user.username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 16, color: AppColors.primaryRed),
              const SizedBox(width: 4),
              Text(user.location, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem(user.bloodType, 'Blood Type'),
              _statItem(user.donated.toString(), 'Donated'),
              _statItem(user.requested.toString(), 'Requested'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _actionButton(text: 'Donate', imagePath: 'assets/imgs/donate.png', color: AppColors.primaryRed, onTap: () {})),
              const SizedBox(width: 16),
              Expanded(child: _actionButton(text: 'Request', imagePath: 'assets/imgs/help.png', color: AppColors.primaryRed, onTap: () {})),
            ],
          ),
          const SizedBox(height: 16),
          _buildAvailabilityToggle(),
          const SizedBox(height: 16),
          _actionButton(text: 'Support', imagePath: 'assets/imgs/sup.png', color: const Color(0xFF8A98E5), onTap: () {}),
          const SizedBox(height: 16),
          _buildSignOutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- CORRECTED METHOD ---
  Widget _buildEditProfileForm() {
    // Define the user variable locally within this method's scope.
    final user = controller.user.value;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 30),
          // Now these calls are valid.
          _buildProfileField(label: 'Username', controller: controller.usernameController, hint: user.username),
          _buildProfileField(label: 'Email', controller: controller.emailController, hint: user.email),
          _buildProfileField(label: 'Phone', controller: controller.phoneController, hint: user.phone),
          _buildProfileField(label: 'Date Of Birth', controller: controller.dobController, hint: user.dateOfBirth),
          _buildProfileField(label: 'Gender', controller: controller.genderController, hint: user.gender),
          _buildProfileField(label: 'Location', controller: controller.locationController, hint: 'Enter Location', hasIcon: true),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Container(
      width: (Get.width - 48 - 32) / 3, // Responsive width
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _actionButton({required String text, required String imagePath, required Color color, required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: color.withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 20, color: Colors.white),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Available for donate', style: TextStyle(fontWeight: FontWeight.w500)),
          Obx(() => Switch(
            value: controller.user.value.isAvailable,
            onChanged: controller.toggleAvailability,
            activeColor: AppColors.primaryRed,
          )),
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return GestureDetector(
      onTap: controller.signOut,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Sign out', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w500, fontSize: 16)),
            Image.asset('assets/imgs/signout.png', height: 20, color: AppColors.primaryRed),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({required String label, required TextEditingController controller, required String hint, bool hasIcon = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              prefixIcon: hasIcon ? const Icon(Icons.location_on, color: AppColors.primaryRed, size: 20) : null,
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryRed)),
            ),
          ),
        ],
      ),
    );
  }
}