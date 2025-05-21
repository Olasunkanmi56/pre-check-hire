import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_acount_manage.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_helpcenter.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_kyc_verification.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_login.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_logout.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_notification.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_privacypolicy.dart';
import 'package:precheck_hire/screens/blacklist_screens/blackllist_security.dart';
import 'package:precheck_hire/services/auth_service.dart';

class BlacklistProfileScreen extends StatelessWidget {
  const BlacklistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: const BackButton(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18.w),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16.w),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12.r),
            //     ),
            //     child: SizedBox(
            //       height: 60.h, // Adjust height to fit content
            //       child: ListView(
            //         scrollDirection: Axis.horizontal,
            //         children: [
            //           _buildStat("5", "Posted Jobs", Icons.work),
   
            //           _buildStat(
            //             "3",
            //             "Total Applications",
            //             Icons.manage_history,
            //           ),
 
            //           _buildStat("4", "Notification", Icons.notifications),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

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
                            builder: (_) => BlacklistAccountManagementScreen(),
                          ),
                        );
                      },
                    ),
                    _optionTile(
                      "KYC Verification",
                      Icons.manage_accounts,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BlacklistKycVerifictionScreen()),
                        );
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
                            builder: (_) => BlacklistSecurityScreen(),
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
                            builder: (_) => BlacklistPrivacyPolicyScreen(),
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
                            builder: (_) => BlacklistNotificationScreen(),
                          ),
                        );
                      },
                    ),
                    // _optionTile(
                    //   "Manage Workers Request",
                    //   Icons.people_alt_outlined,
                    //   onTap: () {
                    //     // Navigate or do something
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (_) => BlacklisTManageWorkerScreen()),
                    //     );
                    //   },
                    // ),
                    _optionTile(
                      "Help and Support",
                      Icons.help_outline,
                      onTap: () {
                        // Navigate or do something
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlacklistHelpCenterScreen(),
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
                        showBlacklistLogoutModal(context, () async {
                          try {
                            await AuthService().logout();

                            // Navigate to login screen directly and clear navigation stack
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => BlacklistLoginScreen()),
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Logout failed. Please try again.',
                                ),
                              ),
                            );
                          }
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

 Widget _buildStat(String count, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.r, color: Colors.blue),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: Colors.black54),
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
