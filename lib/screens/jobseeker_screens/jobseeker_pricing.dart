import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_pricing_success.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_pricing_success.dart';

class JobSeekerPricingScreen extends StatelessWidget {
  const JobSeekerPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'Pricing',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightCard(),
            SizedBox(height: 20.h),
            _buildPricingBox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD600),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: 'Get Full Hiring Access: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  'Make a payment to access our comprehensive domestic worker hiring services and find the perfect candidate!',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Dark top section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2A37),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Blacklist Plan',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Access to Precheck Blacklist',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            '₦ 2500.00/mo',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.h),

          // Disabled features
          _disabledFeature(icon: Icons.block, label: 'Blacklist Candidate'),
          SizedBox(height: 12.h),
          _disabledFeature(
              icon: Icons.visibility_off, label: 'View All Blacklisted Candidate'),
          SizedBox(height: 24.h),

          // Subscribe button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobSeekerPricingSuccess(),
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F2A37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _disabledFeature({required IconData icon, required String label}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 18.r),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
