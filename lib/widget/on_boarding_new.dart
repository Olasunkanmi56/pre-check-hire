import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingCardNew extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? description; // optional single-line description
  final List<String>? bulletPoints; // optional bullet-style points
  final VoidCallback onPressed;
  final PageController pageController;
  final int pageCount;
  final Color bgColor;

  const OnboardingCardNew({
    super.key,
    required this.imagePath,
    required this.title,
    this.description,
    this.bulletPoints,
    required this.onPressed,
    required this.pageController,
    required this.pageCount,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            // Blue top section
            Container(
              height: 0.63.sh,
              width: 1.sw,
              color: bgColor,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo/precheckhire6.png",
                        width: 128.w,
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Phone/image centered
            Positioned(
              top: 0.18.sh,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 0.75.sw,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // White curved container
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: TopOvalClipper(),
                child: Container(
                  width: 1.sw,
                  height: 0.47.sh,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Description or Bullet Points
                      if (description != null)
                        Text(
                          description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                          ),
                        )
                      else if (bulletPoints != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              bulletPoints!
                                  .map(
                                    (point) => Padding(
                                      padding: EdgeInsets.only(bottom: 6.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            size: 16.sp,
                                            color: const Color(0xFF3B82F6),
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              point,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),

                      SizedBox(height: 30.h),

                      // Button
                      GestureDetector(
                        onTap: onPressed,
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Page Indicator
                      SmoothPageIndicator(
                        controller: pageController,
                        count: pageCount,
                        axisDirection: Axis.horizontal,
                        effect: CustomizableEffect(
                          activeDotDecoration: DotDecoration(
                            width: 8,
                            height: 20,
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          dotDecoration: DotDecoration(
                            width: 8,
                            height: 14,
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          spacing: 5.0,
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
    );
  }
}

class TopOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 50);
    path.quadraticBezierTo(size.width / 2, -50, size.width, 50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
