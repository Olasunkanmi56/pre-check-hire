import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployerPrivacyPolicyScreen extends StatelessWidget {
  const EmployerPrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: ListView(
          children: [
            _buildSectionTitle("1. Introduction"),
            _buildSectionText(
              "Welcome to Precheck Hire. By accessing or using our platform, you agree to comply with these Terms of Service. Please read them carefully before using our services. If you do not agree with these terms, you should not use our platform.",
            ),
            SizedBox(height: 24.h),
            _buildSectionTitle("2. Eligibility"),
            _buildSectionText(
              "By using Precheck Hire, you confirm that you are at least 18 years old and legally capable of entering into a binding contract. If you are using our platform on behalf of an organization, you represent that you have the authority to bind that organization to these terms.",
            ),
            SizedBox(height: 24.h),
            _buildSectionTitle("3. User Accounts"),
            _buildSectionText(
              "To use certain features of our platform, you may need to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to provide accurate and up-to-date information when creating your account.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSectionText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}
