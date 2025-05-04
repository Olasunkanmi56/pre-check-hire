import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCard extends StatelessWidget {
  final String title;
  final int applicants;
  final String postedDate;
  final VoidCallback onDelete;
  final VoidCallback onView;
  final IconData icon; 

  const JobCard({
    super.key,
    required this.title,
    required this.applicants,
    required this.postedDate,
    required this.onDelete,
    required this.onView,
    this.icon = Icons.work_outline, // <-- default icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.r,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
               SizedBox(width: 8.w),
              Icon(icon, size: 22.sp, color: Colors.black54),
             
              
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "Applicants: $applicants",
            style: TextStyle(fontSize: 12.sp, color: Colors.black54,     fontWeight: FontWeight.w500, ),
          ),
          Text(
            "Posted on: $postedDate",
            style: TextStyle(fontSize: 12.sp, color: Colors.black54,     fontWeight: FontWeight.w500,),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFfb0206),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("Delete", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500,)),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onView,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C8CE7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("View", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500,)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
