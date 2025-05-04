import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:flutter_svg/flutter_svg.dart';
import 'package:precheck_hire/screens/employer_screens/employer_home_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_notification_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_profile.dart';
import 'package:precheck_hire/screens/employer_screens/employer_request_domestic_worker.dart';
import 'package:precheck_hire/screens/employer_screens/home_navigator.dart';
import 'package:precheck_hire/screens/employer_screens/job_navigator.dart';

class EmployerNavigationMenu extends StatefulWidget {
  const EmployerNavigationMenu({super.key});

  @override
  State<EmployerNavigationMenu> createState() => _EmployerNavigationMenuState();
}

class _EmployerNavigationMenuState extends State<EmployerNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const EmployerHomeNavigator(key: PageStorageKey('HomeNavigator')),
    const EmployerJobsNavigator(key: PageStorageKey('JobsNavigator')),
    const EmployerNotificationScreen(key: PageStorageKey('Notification')),
    const EmployerProfileScreen(key: PageStorageKey('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButton: Container(
        height: 70.w,
        width: 70.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3b82f6), Color(0xFF3845ca)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10.r),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployerRequestDomesticWorkerScreen(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, size: 30.sp, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.w,
        color: const Color(0xFF3845ca),
        elevation: 8,
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem('assets/icons/li_home.svg', "Home", 0),
              _buildNavItem('assets/icons/briefcase.svg', "Jobs", 1),
              SizedBox(width: 40.w),
              _buildNavItem('assets/icons/Notification.svg', "Notification", 2),
              _buildNavItem('assets/icons/Profile.svg', "Profile", 3),
            ],
          ),
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
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

}


