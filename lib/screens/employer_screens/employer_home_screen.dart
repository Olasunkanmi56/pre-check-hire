import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/employer_candidate_profile.dart';
import 'package:precheck_hire/screens/employer_screens/employer_categorylisting_screen.dart';
import 'package:precheck_hire/widget/worker_profile_card.dart';

class EmployerHomeScreen extends StatelessWidget {
  const EmployerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image and greeting
          SizedBox(
            width: double.infinity,
            height: 300.h,
            child: Image.asset(
              'assets/images/onboarding/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 71.h,
            left: 24.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi, Deeyah",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Image.asset(
                      'assets/images/home/wave.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  "Discover Workers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Search box (floating)
          Positioned(
            top: 150.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search for domestic workers",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 139, 138, 138),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade700,
                      ),
                      hintText: "Select your location",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade700,
                    ),
                    dropdownColor: Colors.white,
                    items:
                        ["Abia", "Adamawa", "Akwa Ibom", "Anambra"]
                            .map(
                              (state) => DropdownMenuItem(
                                value: state,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  child: Text(
                                    state,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      // Handle selection
                    },
                    validator:
                        (value) =>
                            value == null ? 'Please select a location' : null,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3C8CE7),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable content BELOW the search container
          Padding(
            padding: EdgeInsets.only(top: 400.h),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse by service type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 5.w,
                    runSpacing: 7.h,
                    children: [
                      _buildChip("Senior House Keeper", Colors.amber, () {}),
                      _buildChip("Security Persona", Colors.green, () {}),
                      _buildChip("Personal Assistant", Colors.orange, () {}),
                      _buildChip("Chef", Colors.deepPurple, () {}),
                      _buildChip("Chef", Colors.deepPurple, () {}),
                      _buildChip("Launderer", Colors.red, () {}),
                      _buildChip("Launderer", Colors.red, () {}),
                      _buildChip("Launderer", Colors.red, () {}),
                      _buildChip("Driver", Colors.pink, () {}),
                      _buildChip("See all", Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryListingScreen(),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore Domestic Workers",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/candidates');
                        },
                        child: Text(
                          "see all",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        WorkerCard(
                          name: "Quadri Fashola",
                          experience: 4,
                          imagePath: "assets/images/home/quadri.png",
                          onViewProfile: () {
                            // Navigate to profile page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EmployerCandidateProfileScreen(),
                              ),
                            );
                          },
                        ),
                        WorkerCard(
                          name: "Luca Adams",
                          experience: 7,
                          imagePath: "assets/images/home/luca.png",
                          onViewProfile: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EmployerCandidateProfileScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
