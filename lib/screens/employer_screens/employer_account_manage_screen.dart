import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EmployerAccountManagementScreen extends StatefulWidget {
  const EmployerAccountManagementScreen({super.key});

  @override
  State<EmployerAccountManagementScreen> createState() =>
      _EmployerAccountManagementScreenState();
}

class _EmployerAccountManagementScreenState
    extends State<EmployerAccountManagementScreen> {
  int selectedTab = 0;
  File? _profileImage;
  File? _frontImage;
  File? _backImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, {bool isProfile = false, bool isFront = false}) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(picked.path);
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

  Widget _buildInput(String label, String value, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        TextFormField(
          readOnly: readOnly,
          initialValue: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
    final file = isFront ? _frontImage : _backImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text("Account Management", style: TextStyle(color: Colors.black, fontSize: 16.sp)),
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
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage("assets/images/home/chisom.png") as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery, isProfile: true),
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
                )
              ],
            ),
            SizedBox(height: 8.h),
            Text("Employer", style: TextStyle(fontSize: 13.sp)),
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
            if (selectedTab == 0) ...[
              _buildInput("First name", "Quadri"),
              _buildInput("Last name", "Fashola"),
              _buildInput("Email", "quadriflash123@yahoo.com"),
              _buildInput("Phone Number", "08170451824"),
              _buildInput("Address", "Lagos, Nigeria"),
              Row(
                children: [
                  Text("Subscription Plan", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("No subscription plan",
                        style: TextStyle(fontSize: 10.sp, color: Colors.red)),
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Text("Next Subscription Date", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("not available",
                        style: TextStyle(fontSize: 10.sp, color: Colors.red)),
                  )
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
                  onPressed: () {},
                  child: Text("Save Changes", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                ),
              ),
              SizedBox(height: 24.h),
            ] else ...[
              Row(
                children: [
                  Text("KYC Status", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("Approved",
                        style: TextStyle(fontSize: 10.sp, color: Colors.green)),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              _buildInput("Identity Type", "NIN"),
              _buildInput("Identity Number", "2302840501638"),
              _buildInput("Issue Date", "2023-10-10"),
              _buildInput("Expiry Date", "2030-10-10"),
              _buildImageUpload("Identity Image (Front)", isFront: true),
              _buildImageUpload("Identity Image (Back)", isFront: false),
              _buildInput("KYC Created At", "2023-10-10"),
              _buildInput("KYC Updated At", "2023-10-10"),
            ],
          ],
        ),
      ),
    );
  }
}
