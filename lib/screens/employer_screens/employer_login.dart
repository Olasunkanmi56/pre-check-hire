import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/dtos/login.dto.dart';
import 'package:precheck_hire/screens/employer_screens/employer_forgot_password.dart';
import 'package:precheck_hire/screens/employer_screens/employer_navigation_menu.dart';
// import 'package:precheck_hire/screens/employer_screens/employer_navigation_menu.dart';
import 'package:precheck_hire/screens/employer_screens/employer_sing_up.dart';
import 'package:precheck_hire/screens/employer_screens/employer_submit_kyc.dart';
import 'package:precheck_hire/store/modules/user.module.dart';
import 'package:provider/provider.dart';

class EmployerLoginScreen extends StatefulWidget {
  const EmployerLoginScreen({super.key});

  @override
  State<EmployerLoginScreen> createState() => _EmployerLoginScreenState();
}

class _EmployerLoginScreenState extends State<EmployerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool agreeToTerms = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  'Login To Your Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildLabeledField(
                  label: "Email",
                  hint: "you@example.com",
                  controller: _emailController,
                ),
                _buildPasswordField(
                  label: "Password",
                  isConfirm: false,
                  controller: _passwordController,
                ),

                // SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xFF3B82F6),
                            focusColor: const Color(0xFF3B82F6),
                            value: agreeToTerms,
                            onChanged: (value) {
                              setState(() => agreeToTerms = value!);
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Remember me',
                              style: TextStyle(fontSize: 12.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const EmployerForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => isLoading = true);

                                final loginDto = LoginDto(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  rememberMe: agreeToTerms,
                                );

                                final authStore = context.read<AuthStore>();

                                try {
                                  await authStore.login(loginDto);

                                  if (!mounted) return;

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder:
                                  //         (context) =>
                                  //             const EmployerSubmitKYCScreen(),
                                  //   ),
                                  // );
                                  final user = authStore.user;
                                  if (user?.kycVerificationStatus == true) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const EmployerNavigationMenu(),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const EmployerSubmitKYCScreen(),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (!mounted) return;
                                  String errorMessage = e.toString();
                                  // Optional: clean up message for user
                                  if (errorMessage.contains(
                                    'Incorrect email or password',
                                  )) {
                                    errorMessage =
                                        'Incorrect email or password';
                                  } else if (errorMessage.contains(
                                    'Login error:',
                                  )) {
                                    errorMessage = errorMessage.replaceFirst(
                                      'Exception: Login error: ',
                                      '',
                                    );
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } finally {
                                  if (mounted)
                                    setState(() => isLoading = false);
                                }
                              }
                            },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child:
                        isLoading
                            ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              'Sign in',
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
                      text: 'Already have an account?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
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
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (_, __, ___) =>
                                              const EmployerSignUpScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
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
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value))
                return 'Enter a valid email';
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
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

  Widget _buildPasswordField({
    required String label,
    required bool isConfirm,
    required TextEditingController controller,
  }) {
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
            controller: controller,
            obscureText: !isVisible,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              if (!isConfirm && value.trim().length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
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
