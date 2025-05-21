import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precheck_hire/services/auth_service.dart';

class EmployerAccountManagementScreen extends StatefulWidget {
  const EmployerAccountManagementScreen({super.key});

  @override
  State<EmployerAccountManagementScreen> createState() =>
      _EmployerAccountManagementScreenState();
}
// final String? imageUrl = url as String?;

class _EmployerAccountManagementScreenState
    extends State<EmployerAccountManagementScreen> {
  final AuthService _authService = AuthService();

  int selectedTab = 1; // 1 = Personal, 0 = KYC
  File? _profileImageUrl;
  File? _frontImage;
  File? _backImage;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _authService.getUserProfile();
      setState(() {
        userData = profile;
        _firstNameController.text = profile['firstName'] ?? '';
        _lastNameController.text = profile['lastName'] ?? '';
        _phoneController.text = profile['phoneNumber'] ?? '';
        _addressController.text = profile['address'] ?? '';
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load profile: ${e.toString()}")),
      );
    }
  }

  Future<void> _pickImage(
    ImageSource source, {
    bool isProfile = false,
    bool isFront = false,
  }) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        if (isProfile) {
          _profileImageUrl = File(picked.path);
        } else if (isFront) {
          _frontImage = File(picked.path);
        } else {
          _backImage = File(picked.path);
        }
      });
    }
  }

  Widget _buildTabButton(String label, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3282f6) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    String value, [
    TextEditingController? controller,
    bool readOnly = false,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller ?? TextEditingController(text: value),
          readOnly: controller == null || readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildImageUpload(String label, {required bool isFront}) {
    final File? file = isFront ? _frontImage : _backImage;
    final dynamic rawUrl =
        isFront
            ? userData != null
                ? userData!['identityImageFront']
                : null
            : userData != null
            ? userData!['identityImageBack']
            : null;

    final String? url =
        rawUrl != null && rawUrl is String && rawUrl.isNotEmpty ? rawUrl : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: () => _pickImage(ImageSource.gallery, isFront: isFront),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text("Choose File", style: TextStyle(fontSize: 12.sp)),
          ),
        ),
        SizedBox(height: 8.h),
        if (file != null)
          Image.file(file, height: 100.h)
        else if (url != null)
          Image.network(
            url,
            height: 100.h,
            errorBuilder: (_, __, ___) => const Text("Failed to load image"),
          )
        else
          Container(
            height: 100.h,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Center(child: Text("No file selected")),
          ),
        SizedBox(height: 16.h),
      ],
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    return date.split('T').first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Account Management",
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Stack(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage:
                      _profileImageUrl != null
                          ? FileImage(_profileImageUrl!)
                          : (userData?['profileImageUrl'] != null &&
                              userData!['profileImageUrl']
                                  .toString()
                                  .isNotEmpty)
                          ? NetworkImage(userData!['profileImageUrl'])
                          : const AssetImage(
                                'assets/images/default_profile.png',
                              )
                              as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap:
                        () => _pickImage(ImageSource.gallery, isProfile: true),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.edit, size: 16.r, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              userData?['role'] ?? 'Employer',
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  _buildTabButton("Personal Details", 1),
                  _buildTabButton("KYC", 0),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            if (selectedTab == 1) ...[
              _buildInput("First name", "", _firstNameController),
              _buildInput("Last name", "", _lastNameController),
              _buildInput("Email", userData?['email'] ?? "", null, true),
              _buildInput("Phone Number", "", _phoneController),
              _buildInput("Address", "", _addressController),
              Row(
                children: [
                  Text("Subscription Plan", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      userData?['subscriptionPlan']?['name'] ??
                          "No subscription plan",
                      style: TextStyle(fontSize: 10.sp, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Text(
                    "Next Subscription Date",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      userData?['nextSubscriptionDate'] ?? "not available",
                      style: TextStyle(fontSize: 10.sp, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3282F6),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      print("Sending update with:");
                      print("First Name: ${_firstNameController.text}");
                      print("Last Name: ${_lastNameController.text}");
                      print("Phone Number: ${_phoneController.text}");
                      print("Address: ${_addressController.text}");
                      print("Profile Image Path: ${_profileImageUrl?.path}");

                      await _authService.updateUserProfile(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: _phoneController.text,
                        address: _addressController.text,
                        profileImageUrl: _profileImageUrl,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile updated successfully"),
                        ),
                      );
                      _loadUserProfile();
                    } catch (e) {
                      print("Update failed: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Update failed: $e")),
                      );
                    }
                  },

                  child: Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ] else ...[
              Row(
                children: [
                  Text("KYC Status", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      userData?['kycVerificationStatus'] ?? "not submitted",
                      style: TextStyle(fontSize: 10.sp, color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildInput("Identity Type", userData?['identityTypeName'] ?? ""),
              _buildInput("Identity Number", userData?['identityNumber'] ?? ""),
              _buildInput(
                "Issue Date",
                formatDate(userData?['identityIssueDate']),
              ),
              _buildInput(
                "Expiry Date",
                formatDate(userData?['identityExpiryDate']),
              ),
              _buildImageUpload("Identity Image (Front)", isFront: true),
              _buildImageUpload("Identity Image (Back)", isFront: false),
              _buildInput("KYC Created At", formatDate(userData?['createdAt'])),
              _buildInput("KYC Updated At", formatDate(userData?['updatedAt'])),
            ],
          ],
        ),
      ),
    );
  }
}
