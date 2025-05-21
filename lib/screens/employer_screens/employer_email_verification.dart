import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/employer_login.dart';
import 'package:precheck_hire/screens/employer_screens/employer_submit_kyc.dart';
import 'package:precheck_hire/services/auth_service.dart'; // Make sure this exists

class EmployerEmailVerificationScreen extends StatefulWidget {
  final String email; 

  const EmployerEmailVerificationScreen({super.key, required this.email});

  @override
  State<EmployerEmailVerificationScreen> createState() =>
      _EmployerEmailVerificationScreenState();
}

class _EmployerEmailVerificationScreenState
    extends State<EmployerEmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _resendVerificationCode() async {
    setState(() => _isLoading = true);
    try {
      await _authService.sendVerificationEmail(widget.email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification code resent to your email')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to resend code: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _verifyEmailToken() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);
  try {
    final email = widget.email.trim();
    final token = _tokenController.text.trim();

    print('Verifying email for: $email');
    print('Token: "$token"');

    await _authService.verifyEmailToken(
      email: email,
      token: token,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email verified successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const EmployerLoginScreen(),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Image.asset(
                  'assets/images/logo/precheckhire6.png',
                  height: 40.h,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Email Verification',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Please enter the verification token sent to your email.',
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 24.h),
                _buildLabeledField(
                  label: "Verification Token",
                  hint: "Enter verification code",
                  controller: _tokenController,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyEmailToken,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text(
                              'Verify Email',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: _isLoading ? null : _resendVerificationCode,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: controller,
            validator:
                (value) =>
                    value == null || value.isEmpty ? "Token is required" : null,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
