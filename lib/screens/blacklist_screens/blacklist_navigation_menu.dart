import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_home_navigator.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_notification.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_profile.dart';

class BlacklistNavigationMenu extends StatefulWidget {
  const BlacklistNavigationMenu({super.key});

  @override
  State<BlacklistNavigationMenu> createState() =>
      _BlacklistNavigationMenuState();
}

class _BlacklistNavigationMenuState extends State<BlacklistNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BlacklistHomeNavigator(),
    const BlacklistNotificationScreen(),
    const BlacklistProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 61.h,
        decoration: BoxDecoration(
          color: const Color(0xFF3845CA),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30.r),
          //   topRight: Radius.circular(30.r),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/icons/li_home.svg', 'Home', 0),
            _buildNavItem('assets/icons/Profile.svg', 'Profile', 2),
            _buildNavItem('assets/icons/Notification.svg', 'Notification', 1),
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
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
