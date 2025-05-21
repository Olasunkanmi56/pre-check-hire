import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/services/auth_service.dart';

class EmployerSecurityScreen extends StatefulWidget {
  const EmployerSecurityScreen({super.key});

  @override
  State<EmployerSecurityScreen> createState() => _EmployerSecurityScreenState();
}

class _EmployerSecurityScreenState extends State<EmployerSecurityScreen> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("New password and confirmation do not match")),
      );
      return;
    }

    try {
      final response = await AuthService().changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      

      if (response.data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password updated successfully")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update password: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Change Password",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            SvgPicture.asset(
              'assets/icons/padlock.svg',
              width: 60.w,
              height: 75.w,
              color: Color(0xFFFD6150),
            ),
            SizedBox(height: 30.h),

            _buildPasswordField(
              label: "Current Password",
              obscure: _obscureCurrent,
              onToggle:
                  () => setState(() => _obscureCurrent = !_obscureCurrent),
              controller: _currentPasswordController,
            ),
            SizedBox(height: 16.h),

            _buildPasswordField(
              label: "New Password",
              obscure: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
            controller:  _newPasswordController,
            ),
            SizedBox(height: 16.h),

            _buildPasswordField(
              label: "Confirm new Password",
              obscure: _obscureConfirm,
              onToggle:
                  () => setState(() => _obscureConfirm = !_obscureConfirm),
                  controller: _confirmPasswordController,
            ),
            SizedBox(height: 30.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3282F6),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Reset password",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade400,
              letterSpacing: 2,
            ),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: onToggle,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
