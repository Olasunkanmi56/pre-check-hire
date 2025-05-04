import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/on_oboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnOboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/logo/prechecklogo.png",
                width: 185.w,
                height: 58.h,
              ),
            ),
          ),

          // Loader
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
              strokeWidth: 3.w,
            ),
          ),
        ],
      ),
    );
  }
}
