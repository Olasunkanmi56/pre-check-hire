import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_reset_password.dart';
import 'package:precheck_hire/screens/employer_screens/employer_login.dart';
import 'package:precheck_hire/services/auth_service.dart';

class BlackListForgotPasswordScreen extends StatefulWidget {
  const BlackListForgotPasswordScreen({super.key});

  @override
  State<BlackListForgotPasswordScreen> createState() =>
      _BlackListForgotPasswordScreenState();
}

class _BlackListForgotPasswordScreenState
    extends State<BlackListForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
   final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
    bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // remove back button if not needed
      ),
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
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Please enter your email address. You will receive a token to create a new password via email.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildLabeledField(label: "Email", hint: "you@example.com",controller: _emailController),

                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                     onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);
                              try {
                                await _authService.forgotPassword(_emailController.text.trim());
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Reset token sent to email'),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlacklistResetPasswordScreen(email: _emailController.text),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                              } finally {
                                setState(() => _isLoading = false);
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
                      'Send',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () {},
                  child: Text.rich(
                    TextSpan(
                      text: 'Remember your password?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFFFB0206),
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const EmployerLoginScreen(),
                                    ),
                                  );
                                },
                        ),
                      ],
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

  Widget _buildLabeledField({required String label, required String hint, required TextEditingController controller}) {
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
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 139, 138, 138),
                ), // stays grey even when focused
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
