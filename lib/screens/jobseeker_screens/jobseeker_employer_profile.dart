import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class EmployerProfileScreen extends StatelessWidget {
  const EmployerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          'Employer Profile',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    'assets/images/employer_banner.jpg', // Replace with your banner
                    width: double.infinity,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -40.h,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 36.r,
                      backgroundImage: AssetImage(
                        'assets/images/avatar.jpg', // Replace with employer photo
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Text(
              'Temitope Ayetoro',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              'Ilesa, Osun',
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
            SizedBox(height: 16.h),

            // Contact Info Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  _infoRow("Email Address", "temitopeayetoro@gmail.com", Icons.email_outlined),
                  _infoRow("Phone Number", "08100011122", Icons.phone_outlined),
                  _infoRow("Number of Job Vacancies", "4", Icons.work_outline),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text("Social:", style: TextStyle(fontSize: 13.sp)),
                      const Spacer(),
                      Icon(FontAwesomeIcons.facebook, size: 16.sp),
                      SizedBox(width: 12.w),
                      Icon(FontAwesomeIcons.instagram, size: 16.sp),
                      SizedBox(width: 12.w),
                      Icon(FontAwesomeIcons.twitter, size: 16.sp),
                      SizedBox(width: 12.w),
                      Icon(FontAwesomeIcons.linkedinIn, size: 16.sp),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Domestic Jobs Title
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Domestic Jobs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Job List
            SizedBox(
              height: 170.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return _jobCard();
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.blueAccent),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
                Text(value,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobCard() {
    return Container(
      width: 180.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "Home Cleaner",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text("Lagos, Kosofe", style: TextStyle(fontSize: 11.sp)),
          SizedBox(height: 8.h),
          Text("Temitope Ayetoro", style: TextStyle(fontSize: 12.sp)),
          Text("21 days ago", style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 30.h),
              backgroundColor: const Color(0xFF3A61ED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text("VIEW DETAILS", style: TextStyle(fontSize: 12.sp)),
          )
        ],
      ),
    );
  }
}
