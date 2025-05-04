import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/employer_screens/employer_account_manage_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_help_center_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_jobs_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_logout.dart';
import 'package:precheck_hire/screens/employer_screens/employer_navigation_menu.dart';
import 'package:precheck_hire/screens/employer_screens/employer_notification_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_privacy_policy_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_security_screen.dart';
import 'package:precheck_hire/screens/employer_screens/home_navigator.dart';

class EmployerProfileScreen extends StatelessWidget {
  const EmployerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const EmployerNavigationMenu(),
        //       ),
        //       (route) => false,
        //     );
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        // ),
         automaticallyImplyLeading: false,
        title: Padding(
           padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Header Gradient
                Center(
                  child: Container(
                    width: 327.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3847E5), Color(0xFF36353C)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                // Profile Details
                Positioned(
                  top: 70.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage: AssetImage(
                            "assets/images/home/chisom.png",
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Quadri Fashola",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Domestic category not available",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.h),

            // Profile Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SizedBox(
                  height: 60.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildStat(
                        "5",
                        "Posted Jobs",
                        'assets/icons/p7.svg',
                        Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 5.w),
                      _buildStat(
                        "3",
                        "Total Applications",
                        'assets/icons/p8.svg',
                        Color(0xFFFB0206),
                      ),
                      SizedBox(width: 5.w),
                      _buildStat(
                        "4",
                        "Notification",
                        'assets/icons/p9.svg',
                        Color.fromARGB(255, 59, 246, 90),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Options List
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView(
                  children: [
                    _optionTile(
                      "Account Management",
                      Icons.manage_accounts,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerAccountManagementScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "KYC Verification",
                      Icons.manage_accounts,
                      onTap: () {
                        // Navigate or do something
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (_) => EditProfilePage()),
                        // );
                      },
                    ),
                    _optionTile(
                      "Security",
                      Icons.lock_outline,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerSecurityScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "Privacy Policy",
                      Icons.privacy_tip_outlined,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerPrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "Notification",
                      Icons.notifications,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerNotificationScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "Manage Workers Request",
                      Icons.people_alt_outlined,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerJobsScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "Help and Support",
                      Icons.help_outline,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmployerHelpCenterScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    _optionTile(
                      "Log out",
                      Icons.logout,
                      color: Colors.red,
                      iconColor: Colors.red,
                      onTap: () {
                        EmployerLogoutModal(context, () {
                          print("User logged out");
                          // Navigator.pushReplacementNamed(context, '/login');
                        });
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label, String svgPath, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.r,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            child: SvgPicture.asset(
              svgPath,
              width: 24.sp,
              height: 24.sp,
              color: Colors.black38, // optional
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 40.h, width: 1.w, color: Colors.grey.shade300);
  }

  Widget _optionTile(
    String title,
    IconData icon, {
    Color? color,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.r, color: iconColor ?? const Color(0xFF3282f6)),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: color ?? Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
