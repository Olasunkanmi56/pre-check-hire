import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_application_screen.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_home.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_navigator.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_notification.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_profile.dart';

class JobSeekerNavigationMenu extends StatefulWidget {
  const JobSeekerNavigationMenu({super.key});

  @override
  State<JobSeekerNavigationMenu> createState() =>
      _JobSeekerNavigationMenuState();
}

class _JobSeekerNavigationMenuState extends State<JobSeekerNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const JobseekerNavigator(),
    JobSeekerApplicationScreen(),
    const JobSeekerNotificationScreen(),
    JobSeekerProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: const Color(0xFF3845ca), // Blue background
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/icons/li_home.svg', "Home", 0),
            _buildNavItem('assets/icons/eye.svg', "Views", 1),
            _buildNavItem('assets/icons/Notification.svg', "Notification", 2),
            _buildNavItem('assets/icons/Profile.svg', "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgAsset, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 24.sp,
            height: 24.sp,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
