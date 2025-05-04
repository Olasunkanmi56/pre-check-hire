import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int experience;
  final VoidCallback onViewProfile;

  const WorkerCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.experience,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 260.h, // <-- Add a fixed height to avoid Column overflow
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top section with colored background
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
          ),

          // Profile picture overlaps the top background
          Container(
            transform: Matrix4.translationValues(0, -30.h, 0),
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imagePath),
            ),
          ),

          // Name & experience
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Experience: '),
                      TextSpan(
                        text: '$experience years',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // View Profile button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onViewProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C8CE7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
                child: Text(
                  'View Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
