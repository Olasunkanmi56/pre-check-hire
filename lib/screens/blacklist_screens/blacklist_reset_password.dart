import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_login.dart';
import 'package:precheck_hire/services/auth_service.dart';

class BlacklistResetPasswordScreen extends StatefulWidget {
   final String email;
  const BlacklistResetPasswordScreen({super.key, required this.email});
  

  @override
  State<BlacklistResetPasswordScreen> createState() =>
      _BlacklistResetPasswordScreenState();
}

class _BlacklistResetPasswordScreenState
    extends State<BlacklistResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

   final AuthService _authService = AuthService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

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
                  'Please enter your new password and input the generated token..',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildLabeledField(label: "Token", hint: "Enter the token sent to your email"),
                _buildLabeledField(label: "Email", hint: widget.email),
                _buildPasswordField(label: "Password", isConfirm: false),
                _buildPasswordField(label: "Confirm Password", isConfirm: true),
                // SizedBox(height: 5.h),

                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          try {
                            await _authService.resetPassword(
                              email: widget.email,
                              token: _tokenController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            );
                            // Show success message or navigate to login screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password reset successful!"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlacklistLoginScreen(),
                              ),
                            );
                          } catch (e) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        } else {
                          // Show error: passwords do not match
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Passwords do not match!"),
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
                      'Reset password',
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
                  onTap: () {
                    // Navigate to Sign In
                  },
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
                                              const BlacklistLoginScreen(),
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

  Widget _buildLabeledField({required String label, required String hint}) {
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

  Widget _buildPasswordField({required String label, required bool isConfirm}) {
    final isVisible = isConfirm ? showConfirmPassword : showPassword;

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
            obscureText: !isVisible,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              suffixIcon: IconButton(
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      showConfirmPassword = !showConfirmPassword;
                    } else {
                      showPassword = !showPassword;
                    }
                  });
                },
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
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
