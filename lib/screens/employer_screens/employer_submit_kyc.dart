import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precheck_hire/screens/employer_screens/employer_kyc_success.dart';
import 'package:precheck_hire/services/auth_service.dart';
import 'package:precheck_hire/store/modules/miscellaneous.module.dart';

class EmployerSubmitKYCScreen extends StatefulWidget {
  const EmployerSubmitKYCScreen({super.key});

  @override
  State<EmployerSubmitKYCScreen> createState() =>
      _EmployerSubmitKYCScreenState();
}

class _EmployerSubmitKYCScreenState extends State<EmployerSubmitKYCScreen> {
  final _formKey = GlobalKey<FormState>();
  final identityNumberController = TextEditingController();

  // Mock data
  List<Map<String, dynamic>> idTypes = [];
  Map<String, dynamic>? selectedIdType;

  bool isLoading = true;

  @override
  void dispose() {
    identityNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchIdentityTypes();
  }

  void fetchIdentityTypes() async {
    try {
      idTypes =
          await MiscellaneousModule()
              .getIdentityTypes(); // Should return List<Map<String, dynamic>>
      if (idTypes.isNotEmpty) {
        selectedIdType = idTypes.first;
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching identity types: $e');
    }
  }

  DateTime? issueDate;
  DateTime? expiryDate;

  // For file picking placeholders
  String frontImageName = 'mybackground.jpg';
  String backImageName = 'mybackground.jpg';

  String? frontImagePath;
  String? backImagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage({required bool isFront}) async {
    // Let user choose between camera and gallery
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
              ],
            ),
          ),
    );

    if (source == null) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          frontImagePath = pickedFile.path;
        } else {
          backImagePath = pickedFile.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // White background + no elevation for a clean look
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // or your custom logic
          },
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Image.asset(
                    'assets/images/logo/precheckhire6.png',
                    height: 40.h,
                  ),
                ),
                SizedBox(height: 24.h),
                // Title
                Center(
                  child: Text(
                    "Let Us Know You",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Subtitle
                Text(
                  "Submit KYC document",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20.h),

                // Identity Type (Dropdown)
                Text(
                  "Identity Type",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: DropdownButtonFormField<Map<String, dynamic>>(
                    value: selectedIdType,
                    items:
                        idTypes.map((typeMap) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: typeMap,
                            child: Text(typeMap['name']),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() => selectedIdType = val!);
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 16.h),

                // Identity Number
                _buildLabel("Identity Number"),
                _buildTextFormField("e.g 123456789", identityNumberController),

                // Issue Date
                _buildLabel("Issue Date"),
                _buildDatePickerField(
                  hintText: "mm/dd/yyyy",
                  selectedDate: issueDate,
                  onDatePicked: (picked) {
                    setState(() => issueDate = picked);
                  },
                ),

                // Expiry Date
                _buildLabel("Expiry Date"),
                _buildDatePickerField(
                  hintText: "mm/dd/yyyy",
                  selectedDate: expiryDate,
                  onDatePicked: (picked) {
                    setState(() => expiryDate = picked);
                  },
                ),

                // Identity Image (front)
                _buildLabel("Identity image (front)"),
                _buildFilePicker(
                  filePath: frontImagePath,
                  onPickFile: () {
                    _pickImage(isFront: true);
                  },
                ),

                // Identity Image (back)
                _buildLabel("Identity image (back)"),
                _buildFilePicker(
                  filePath: backImagePath,
                  onPickFile: () {
                    _pickImage(isFront: false);
                  },
                ),

                SizedBox(height: 20.h),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (frontImagePath == null || backImagePath == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select both front and back identity images.',
                            ),
                          ),
                        );
                        return;
                      }

                      if (issueDate == null || expiryDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select issue and expiry dates.',
                            ),
                          ),
                        );
                        return;
                      }

                      // Show loading dialog
                      _showVerificationDialog();

                      try {
                        final authService =
                            AuthService(); // Adjust if using dependency injection
                        await authService.submitKYC(
                          identityTypeId: selectedIdType!['id'],
                          identityNumber: identityNumberController.text.trim(),
                          identityIssueDate: issueDate!,
                          identityExpiryDate: expiryDate!,
                          identityImageFrontPath: frontImagePath!,
                          identityImageBackPath: backImagePath!,
                        );

                        if (mounted) {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EmployerKycSuccessScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          Navigator.pop(context); // Close the dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Submission failed: ${e.toString()}',
                              ),
                            ),
                          );
                        }
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Basic TextFormField
  Widget _buildTextFormField(String hint, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 11, // Optional: enforces length in UI
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Identity number is required';
        }
        if (value.trim().length > 11) {
          return 'Identity number must not exceed 11 digits';
        }
        if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
          return 'Only numeric digits are allowed';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        counterText: '', // hides character counter if using maxLength
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: const Color.fromARGB(255, 139, 138, 138)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    ),
  );
}


  // Date Picker
  Widget _buildDatePickerField({
    required String hintText,
    required DateTime? selectedDate,
    required Function(DateTime pickedDate) onDatePicked,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 139, 138, 138),
            ), // stays grey even when focused
          ),
          hintText:
              selectedDate == null
                  ? hintText
                  : "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}",
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final now = DateTime.now();
              final firstDate = DateTime(now.year - 30);
              final lastDate = DateTime(now.year + 30);

              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? now,
                firstDate: firstDate,
                lastDate: lastDate,
              );

              if (picked != null) {
                onDatePicked(picked);
              }
            },
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
    );
  }

  // File Picker placeholder
  Widget _buildFilePicker({
    required String? filePath,
    required VoidCallback onPickFile,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
            child: ElevatedButton(
              onPressed: onPickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                "Choose file",
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filePath != null
                      ? filePath.split('/').last
                      : "No file chosen",
                  style: TextStyle(fontSize: 14.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                if (filePath != null)
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: SizedBox(
                      height: 80.h,
                      child: Image.file(File(filePath), fit: BoxFit.cover),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent closing by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Color(0xFFFFC107)),
                SizedBox(height: 20.h),
                Text(
                  "Your KYC document is awaiting verification.\nPlease check back later.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
