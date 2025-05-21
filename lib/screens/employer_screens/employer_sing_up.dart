import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/dtos/signup_request_dto.dart';
import 'package:precheck_hire/screens/employer_screens/employer_email_verification.dart';
import 'package:precheck_hire/screens/employer_screens/employer_login.dart';
import 'package:precheck_hire/screens/employer_screens/employer_termofservice_screen.dart';
import 'package:precheck_hire/store/modules/user.module.dart';

class EmployerSignUpScreen extends StatefulWidget {
  const EmployerSignUpScreen({super.key});

  @override
  State<EmployerSignUpScreen> createState() => _EmployerSignUpScreenState();
}

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

class _EmployerSignUpScreenState extends State<EmployerSignUpScreen> {
  final AuthStore authStore = AuthStore();
  final _formKey = GlobalKey<FormState>();
  bool agreeToTerms = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;

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
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),

                _buildLabeledField(
                  label: "First name",
                  hint: "First Name",
                  controller: _firstNameController,
                ),
                _buildLabeledField(
                  label: "Last name",
                  hint: "Last name",
                  controller: _lastNameController,
                ),
                _buildLabeledField(
                  label: "Email",
                  hint: "you@example.com",
                  controller: _emailController,
                ),
                _buildLabeledField(
                  label: "Phone Number",
                  hint: "08123456789",
                  controller: _phoneController,
                ),
                _buildLabeledField(
                  label: "Address",
                  hint: "City, Country",
                  controller: _addressController,
                ),
                _buildPasswordField(
                  label: "Password",
                  isConfirm: false,
                  controller: _passwordController,
                ),
                _buildPasswordField(
                  label: "Confirm Password",
                  isConfirm: true,
                  controller: _confirmPasswordController,
                ),

                SizedBox(height: 12.h),
                Row(
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
                      child: Text.rich(
                        TextSpan(
                          text: 'I Accept ',
                          style: TextStyle(fontSize: 14.sp),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to your Terms and Conditions page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const EmployerTermsOfServiceScreen(),
                                        ),
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    // onPressed: () async {
                    //   if (_passwordController.text.trim() !=
                    //       _confirmPasswordController.text.trim()) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("Passwords do not match")),
                    //     );
                    //     return;
                    //   }

                    //   if (_formKey.currentState!.validate() && agreeToTerms) {
                    //     final signupRequest = SignupRequestDto(
                    //       firstName: _firstNameController.text.trim(),
                    //       lastName: _lastNameController.text.trim(),
                    //       email: _emailController.text.trim().toLowerCase(),
                    //       phoneNumber: _phoneController.text.trim(),
                    //       address: _addressController.text.trim(),
                    //       password: _passwordController.text.trim(),
                    //       role: "candidate",
                    //       subscriptionPlanId: 1,
                    //     );

                    //     try {
                    //       await authStore.signup(signupRequest);
                    //       print("Signed up successfully");

                    //       await authStore.sendVerificationEmail(
                    //         _emailController.text.trim(),
                    //       );

                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder:
                    //               (context) => EmployerEmailVerificationScreen(
                    //                 email: _emailController.text.trim(),
                    //               ),
                    //         ),
                    //       );
                    //     } catch (e) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text("Signup failed, please try again."),
                    //         ),
                    //       );
                    //       print("Signup error: $e"); // Log the detailed error
                    //     }
                    //   }
                    // },
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              if (!_formKey.currentState!.validate()) return;

                              if (!agreeToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please accept Terms and Conditions",
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                isLoading = true;
                              });

                              final signupRequest = SignupRequestDto(
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                email:
                                    _emailController.text.trim().toLowerCase(),
                                phoneNumber: _phoneController.text.trim(),
                                address: _addressController.text.trim(),
                                password: _passwordController.text.trim(),
                                role: "candidate",
                                subscriptionPlanId: 1,
                              );

                              try {
                                await authStore.signup(signupRequest);
                                await authStore.sendVerificationEmail(
                                  _emailController.text.trim(),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => EmployerEmailVerificationScreen(
                                          email: _emailController.text.trim(),
                                        ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Signup failed, please try again.",
                                    ),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    // child: Text(
                    //   'Sign up',
                    //   style: TextStyle(
                    //     fontSize: 16.sp,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    child:
                        isLoading
                            ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Sign up',
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
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (_, __, ___) =>
                                              const EmployerLoginScreen(),
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
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }

            if (label == 'First name' || label == 'Last name') {
              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                return '$label should contain only letters';
              }
            }

            if (label == 'Email') {
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value.trim())) {
                return 'Enter a valid email address';
              }
            }

            if (label == 'Phone Number') {
              if (!RegExp(r'^\d{9,}$').hasMatch(value.trim())) {
                return 'Enter a valid phone number (at least 9 digits)';
              }
            }

            return null;
          },
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
              borderSide: BorderSide(color: Colors.grey),
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
              if (isConfirm &&
                  value.trim() != _passwordController.text.trim()) {
                return 'Passwords do not match';
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
