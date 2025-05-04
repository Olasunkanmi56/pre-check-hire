import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? description;
  final String btnText;
  final VoidCallback onPressed;
  final String? bottomText;
  final String? bottomActionText;
  final VoidCallback? onBottomActionTap;

  // Optional buttons
  final String? optionalBtn1Text;
  final VoidCallback? optionalBtn1Pressed;

  final String? optionalBtn2Text;
  final VoidCallback? optionalBtn2Pressed;

  const OnboardingCard({
    Key? key,
    required this.imagePath,
    required this.title,
    this.description,
    required this.btnText,
    required this.onPressed,
    this.optionalBtn1Text,
    this.optionalBtn1Pressed,
    this.optionalBtn2Text,
    this.optionalBtn2Pressed,
    this.bottomText,
    this.bottomActionText,
    this.onBottomActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              child: Image.asset(
                imagePath,
                height: 0.69.sh,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // White card overlayed partially on top of the image
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (description != null)
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                  SizedBox(height: 24.h),

                  // Main Button (required)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.hovered) ||
                                states.contains(WidgetState.pressed)) {
                              return const Color(0xFF2563eb);
                            }
                            return const Color(0xFF3b82f6); // Normal
                          },
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 16.h),
                        ),
                      ),
                      child: Text(
                        btnText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  // Optional Button 1
                  if (optionalBtn1Text != null && optionalBtn1Pressed != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: optionalBtn1Pressed,
                          style: ButtonStyle(
                            side: WidgetStateProperty.resolveWith<BorderSide>((
                              states,
                            ) {
                              if (states.contains(WidgetState.hovered) ||
                                  states.contains(WidgetState.pressed)) {
                                return const BorderSide(
                                  color: Color(0xFF2563eb),
                                  width: 2,
                                );
                              }
                              return const BorderSide(color: Color(0xFF3b82f6));
                            }),
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered) ||
                                      states.contains(WidgetState.pressed)) {
                                    return const Color(0xFF3b82f6);
                                  }
                                  return Colors.transparent;
                                }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered) ||
                                      states.contains(WidgetState.pressed)) {
                                    return Colors.white;
                                  }
                                  return const Color(0xFF3b82f6);
                                }),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(vertical: 16.h),
                            ),
                          ),
                          child: Text(
                            optionalBtn1Text!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Optional Button 2
                  if (optionalBtn2Text != null && optionalBtn2Pressed != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: optionalBtn2Pressed,
                          style: ButtonStyle(
                            side: WidgetStateProperty.resolveWith<BorderSide>((
                              states,
                            ) {
                              if (states.contains(WidgetState.hovered) ||
                                  states.contains(WidgetState.pressed)) {
                                return const BorderSide(
                                  color: Color(0xFF2563eb),
                                  width: 2,
                                );
                              }
                              return const BorderSide(color: Color(0xFF3b82f6));
                            }),
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered) ||
                                      states.contains(WidgetState.pressed)) {
                                    return const Color(0xFF3b82f6);
                                  }
                                  return Colors.transparent;
                                }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered) ||
                                      states.contains(WidgetState.pressed)) {
                                    return Colors.white;
                                  }
                                  return const Color(0xFF3b82f6);
                                }),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(vertical: 16.h),
                            ),
                          ),
                          child: Text(
                            optionalBtn2Text!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Optional Bottom Text (e.g. Already have an account? Sign in)
                  if (bottomText != null &&
                      bottomActionText != null &&
                      onBottomActionTap != null)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: GestureDetector(
                        onTap: onBottomActionTap,
                        child: RichText(
                          text: TextSpan(
                            text: bottomText!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFFaaa6b9),
                            ),
                            children: [
                              TextSpan(
                                text: ' $bottomActionText',
                                style: TextStyle(
                                  color: Color(0xFFFB0206),
                                   fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
