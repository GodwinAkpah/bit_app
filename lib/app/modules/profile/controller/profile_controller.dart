
// import 'package:bit_app/services/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../routes/app_routes.dart';

// class ProfileController extends GetxController {
//   // A reactive variable to hold the user's data. The UI will automatically
//   // update whenever this changes.
//   late Rx<UserModel> user;

//   // A reactive flag to switch between viewing and editing the profile.
//   final RxBool isEditMode = false.obs;
  
//   // Text editing controllers for the 'Edit Profile' form.
//   late TextEditingController usernameController;
//   late TextEditingController emailController;
//   late TextEditingController phoneController;
//   late TextEditingController dobController;
//   late TextEditingController genderController;
//   late TextEditingController locationController;

//   @override
//   void onInit() {
//     super.onInit();
//     // In a real app, you would fetch user data from a database/API here.
//     // For now, we load hardcoded mock data.
//     _loadUserData();
//   }

//   /// Initializes the user object and the text editing controllers.
//   void _loadUserData() {
//     user = UserModel(
//       uid: '123',
//       username: 'Username',
//       email: 'Username@Email.Com',
//       phone: '08022834848',
//       location: 'JOS, PLATEAU STATE',
//       dateOfBirth: '20-11-1996',
//       gender: 'Nil',
//       bloodType: 'A+',
//       donated: 5,
//       requested: 2,
//       isAvailable: true,
//     ).obs;
    
//     // Initialize text controllers with the user's current data.
//     usernameController = TextEditingController(text: user.value.username);
//     emailController = TextEditingController(text: user.value.email);
//     phoneController = TextEditingController(text: user.value.phone);
//     dobController = TextEditingController(text: user.value.dateOfBirth);
//     genderController = TextEditingController(text: user.value.gender);
//     locationController = TextEditingController(text: user.value.location);
//   }

//   /// Toggles the UI between the profile view and the edit form.
//   void toggleEditMode() {
//     isEditMode.value = !isEditMode.value;
//   }

//   /// Updates the user's availability for donation.
//   void toggleAvailability(bool value) {
//     user.update((val) {
//       val?.isAvailable = value;
//     });
//     // TODO: Add an API call here to persist this change.
//   }

//   /// Validates and saves the updated profile information.
//   void saveProfile() {
//     // TODO: Add form validation logic here.
    
//     // TODO: Add an API call to save the data to your backend.
//     print('Saving profile...');

//     // Update the local reactive user model from the text controllers.
//     // The UI will update automatically because `user` is an .obs variable.
//     user.update((val) {
//       val?.username = usernameController.text;
//       val?.email = emailController.text;
//       val?.phone = phoneController.text;
//       val?.dateOfBirth = dobController.text;
//       val?.gender = genderController.text;
//       val?.location = locationController.text;
//     });

//     // Switch back to view mode after saving.
//     toggleEditMode();
//     Get.snackbar('Success', 'Profile updated successfully!', snackPosition: SnackPosition.BOTTOM);
//   }

//   /// Signs the user out and clears the navigation history.
//   void signOut() {
//     // TODO: Add logic here to clear any saved user session/token.
//     Get.offAllNamed(AppRoutes.LOGIN);
//   }

//   /// Dispose of controllers to prevent memory leaks when the screen is closed.
//   @override
//   void onClose() {
//     usernameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     dobController.dispose();
//     genderController.dispose();
//     locationController.dispose();
//     super.onClose();
//   }
// }


import 'package:bit_app/services/auth/auth_service.dart';
import 'package:bit_app/services/models/user_model.dart';
import 'package:bit_app/services/service_manifest.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final AuthService _authService = serviceLocator<AuthService>();
  final _storage = GetStorage();

  late Rx<UserModel> user;
  final RxBool isEditMode = false.obs;
  
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController genderController;
  late TextEditingController locationController;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final userDataMap = _storage.read('user_data');
    if (userDataMap != null) {
      user = UserModel.fromJson(userDataMap).obs;
    } else {
      user = UserModel(
        uid: '123',
        username: 'Username',
        email: 'Username@Email.Com',
        phone: '08022834848',
        location: 'JOS, PLATEAU STATE',
        dateOfBirth: '20-11-1996',
        gender: 'Nil',
        bloodType: 'A+',
        donated: 5,
        requested: 2,
        isAvailable: true,
      ).obs;
    }
    
    usernameController = TextEditingController(text: user.value.username);
    emailController = TextEditingController(text: user.value.email);
    phoneController = TextEditingController(text: user.value.phone);
    dobController = TextEditingController(text: user.value.dateOfBirth);
    genderController = TextEditingController(text: user.value.gender);
    locationController = TextEditingController(text: user.value.location);
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  /// Updates the user's availability for donation.
  void toggleAvailability(bool value) {
    // --- THE FIX IS HERE ---
    user.update((val) {
      if (val != null) {
        val.isAvailable = value;
      }
    });
    // TODO: Add an API call here to persist this change.
  }

  /// Validates and saves the updated profile information.
  void saveProfile() {
    // TODO: Implement API call to update profile.
    
    // --- THE FIX IS HERE ---
    user.update((val) {
      // Add a null check for safety
      if (val != null) {
        val.username = usernameController.text;
        val.email = emailController.text;
        val.phone = phoneController.text;
        val.dateOfBirth = dobController.text;
        val.gender = genderController.text;
        val.location = locationController.text;
      }
    });

    // Save the updated user data back to local storage.
    _storage.write('user_data', user.value.toJson());

    toggleEditMode();
    Get.snackbar('Success', 'Profile updated successfully!', snackPosition: SnackPosition.BOTTOM);
  }

  void signOut() {
    _storage.remove('auth_token');
    _storage.remove('user_data');
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    genderController.dispose();
    locationController.dispose();
    super.onClose();
  }
}