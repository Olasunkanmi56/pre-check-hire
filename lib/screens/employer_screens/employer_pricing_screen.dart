import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/employer_success_pricing.dart';
import 'package:precheck_hire/store/modules/miscellaneous.module.dart'; // Import your auth service

class EmployerPricingScreen extends StatelessWidget {
  const EmployerPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pricing",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: FutureBuilder<Map<String, dynamic>>(
          future: MiscellaneousModule().getEmployerSubscriptionPlan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            var employerPlan = snapshot.data;

            if (employerPlan == null || employerPlan.isEmpty) {
              return const Center(child: Text('No Employer Plan found.'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Plan Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Plan Title
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              employerPlan['name'] ?? "Employer Plan",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              employerPlan['description'] ?? "Access to Precheck Employer",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Price
                      Text(
                        "₦ ${employerPlan['price'] ?? '0.00'}/mo",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Features
                      _buildFeatureItem(employerPlan['features'] ?? [], "Browse Candidate"),
                      _buildFeatureItem(employerPlan['features'] ?? [], "Hire Candidate"),
                      _buildFeatureItem(employerPlan['features'] ?? [], "Manage Candidate"),

                      SizedBox(height: 20.h),

                      // Subscribe Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add subscription logic
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EmployerPricingSuccessScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Subscribe Now",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureItem(List<dynamic> features, String title) {
    bool enabled = features.contains(title);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: enabled ? Colors.blue : Colors.grey,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                enabled ? Icons.check : Icons.close,
                size: 12.sp,
                color: enabled ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
