// import 'package:bit_app/app/modules/blood_request/controller/blood_request_controller.dart';
// import 'package:bit_app/app/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class BloodRequestView extends GetView<BloodRequestController> {
//   const BloodRequestView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Request Blood'),
//         backgroundColor: AppColors.primaryRed,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(16),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 10,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSectionHeader(icon: Icons.bloodtype, title: 'Request Type'),
//               _buildRequestTypeSelector(),
//               const SizedBox(height: 20),

//               _buildSectionHeader(icon: Icons.person, title: 'Name'),
//               _buildTextField(controller.nameController, isEnabled: controller.requestType.value == RequestType.others),
//               const SizedBox(height: 20),

//               _buildSectionHeader(icon: Icons.phone_android, title: 'Mobile No.'),
//               _buildTextField(controller.mobileController, isEnabled: controller.requestType.value == RequestType.others),
//               const SizedBox(height: 20),

//               _buildSectionHeader(icon: Icons.opacity, title: 'Blood Group'),
//               _buildChipGrid(
//                 items: controller.bloodGroups,
//                 selectedItem: controller.selectedBloodGroup,
//                 onSelected: (value) => controller.selectBloodGroup(value as String),
//               ),
//               const SizedBox(height: 20),
              
//               _buildSectionHeader(icon: Icons.colorize, title: 'Pints Units'),
//               _buildChipGrid(
//                 items: controller.pintUnits.map((p) => p.toString()).toList(),
//                 selectedItem: Obx(() => controller.selectedPints.value.toString()),
//                 onSelected: (value) => controller.selectPints(int.parse(value as String)),
//               ),
//               const SizedBox(height: 20),
              
//               _buildSectionHeader(icon: Icons.location_on, title: 'Location'),
//               _buildTextField(controller.locationController, hint: 'Address will help donors navigate easily'),
//               const SizedBox(height: 20),
              
//               _buildSectionHeader(icon: Icons.edit_note, title: 'Reason'),
//               _buildTextField(controller.reasonController, hint: 'Optional', maxLines: 3),
//               const SizedBox(height: 30),
              
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.submitRequest,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryRed,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text('Submit', style: TextStyle(fontSize: 18)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader({required IconData icon, required String title}) {
//     return Row(
//       children: [
//         Icon(icon, color: AppColors.primaryRed, size: 20),
//         const SizedBox(width: 8),
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildRequestTypeSelector() {
//     return Obx(() => Row(
//       children: [
//         Radio<RequestType>(
//           value: RequestType.self,
//           groupValue: controller.requestType.value,
//           onChanged: (val) => controller.setRequestType(val!),
//           activeColor: AppColors.primaryRed,
//         ),
//         const Text('Self'),
//         const SizedBox(width: 20),
//         Radio<RequestType>(
//           value: RequestType.others,
//           groupValue: controller.requestType.value,
//           onChanged: (val) => controller.setRequestType(val!),
//           activeColor: AppColors.primaryRed,
//         ),
//         const Text('Others'),
//       ],
//     ));
//   }

//   Widget _buildTextField(TextEditingController textController, {String? hint, int maxLines = 1, bool isEnabled = true}) {
//     return Obx(() => TextFormField(
//       controller: textController,
//       maxLines: maxLines,
//       enabled: isEnabled,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: isEnabled ? Colors.white : Colors.red.withOpacity(0.1),
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryRed)),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//     ));
//   }

//   Widget _buildChipGrid({
//     required List<String> items,
//     required RxString selectedItem,
//     required Function(dynamic) onSelected,
//   }) {
//     return Obx(() => Wrap(
//       spacing: 10.0,
//       runSpacing: 5.0,
//       children: items.map((item) {
//         final isSelected = selectedItem.value == item;
//         return ChoiceChip(
//           label: Text(item, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
//           selected: isSelected,
//           onSelected: (selected) {
//             if (selected) onSelected(item);
//           },
//           selectedColor: AppColors.primaryRed,
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: isSelected ? AppColors.primaryRed : Colors.grey[300]!),
//           ),
//         );
//       }).toList(),
//     ));
//   }
// }

// // Success Dialog Widget
// class RequestSuccessDialog extends StatelessWidget {
//   const RequestSuccessDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryRed),
//               child: const Icon(Icons.check, color: Colors.white, size: 40),
//             ),
//             const SizedBox(height: 20),
//             const Text('Request Successful', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             const Text(
//               'Your request has been sent.\nCheck notifications for updates.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:bit_app/app/modules/blood_request/controller/blood_request_controller.dart';
import 'package:bit_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestView extends GetView<BloodRequestController> {
  const BloodRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood'),
        backgroundColor: AppColors.primaryRed,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Obx(() => Column( // Wrap column in Obx to rebuild text fields on type change
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(icon: Icons.bloodtype, title: 'Request Type'),
              _buildRequestTypeSelector(),
              const SizedBox(height: 20),

              _buildSectionHeader(icon: Icons.person, title: 'Name'),
              _buildTextField(
                controller.nameController, 
                // Enable/disable based on the reactive requestType
                isEnabled: controller.requestType.value == RequestType.others
              ),
              const SizedBox(height: 20),

              _buildSectionHeader(icon: Icons.phone_android, title: 'Mobile No.'),
              _buildTextField(
                controller.mobileController,
                isEnabled: controller.requestType.value == RequestType.others
              ),
              const SizedBox(height: 20),

              _buildSectionHeader(icon: Icons.opacity, title: 'Blood Group'),
              // --- CORRECTED CALL for Blood Group ---
              _buildChipGrid<String>(
                items: controller.bloodGroups,
                selectedItem: controller.selectedBloodGroup,
                onSelected: controller.selectBloodGroup,
                labelBuilder: (group) => group,
              ),
              const SizedBox(height: 20),
              
              _buildSectionHeader(icon: Icons.colorize, title: 'Pints Units'),
              // --- CORRECTED CALL for Pints ---
              _buildChipGrid<int>(
                items: controller.pintUnits,
                selectedItem: controller.selectedPints,
                onSelected: controller.selectPints,
                labelBuilder: (pint) => pint.toString(), // Convert int to String for the label
              ),
              const SizedBox(height: 20),
              
              _buildSectionHeader(icon: Icons.location_on, title: 'Location'),
              _buildTextField(controller.locationController, hint: 'Address will help donors navigate easily'),
              const SizedBox(height: 20),
              
              _buildSectionHeader(icon: Icons.edit_note, title: 'Reason'),
              _buildTextField(controller.reasonController, hint: 'Optional', maxLines: 3),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryRed, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildRequestTypeSelector() {
    return Obx(() => Row(
      children: [
        Radio<RequestType>(
          value: RequestType.self,
          groupValue: controller.requestType.value,
          onChanged: (val) => controller.setRequestType(val!),
          activeColor: AppColors.primaryRed,
        ),
        const Text('Self'),
        const SizedBox(width: 20),
        Radio<RequestType>(
          value: RequestType.others,
          groupValue: controller.requestType.value,
          onChanged: (val) => controller.setRequestType(val!),
          activeColor: AppColors.primaryRed,
        ),
        const Text('Others'),
      ],
    ));
  }

  Widget _buildTextField(TextEditingController textController, {String? hint, int maxLines = 1, bool isEnabled = true}) {
    // No longer needs Obx here as the parent Column is wrapped
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      enabled: isEnabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: isEnabled ? Colors.white : Colors.grey.withOpacity(0.15),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryRed)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[200]!)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  // --- REWRITTEN GENERIC WIDGET ---
  Widget _buildChipGrid<T>({
    required List<T> items,
    required Rx<T> selectedItem,
    required ValueChanged<T> onSelected,
    required String Function(T) labelBuilder,
  }) {
    return Obx(() => Wrap(
      spacing: 10.0,
      runSpacing: 5.0,
      children: items.map((item) {
        final isSelected = selectedItem.value == item;
        return ChoiceChip(
          label: Text(
            labelBuilder(item),
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              onSelected(item);
            }
          },
          selectedColor: AppColors.primaryRed,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isSelected ? AppColors.primaryRed : Colors.grey[300]!),
          ),
          showCheckmark: false,
        );
      }).toList(),
    ));
  }
}


// --- NO CHANGES NEEDED BELOW THIS LINE ---

// Success Dialog Widget
class RequestSuccessDialog extends StatelessWidget {
  const RequestSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryRed),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            const Text('Request Successful', style: TextStyle(color: AppColors.primaryRed, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Your request has been sent.\nCheck notifications for updates.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}