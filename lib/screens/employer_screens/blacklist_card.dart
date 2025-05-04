import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BlacklistCandidateCard extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  final String imageUrl;
  final VoidCallback onTap;

  const BlacklistCandidateCard({
    super.key,
    required this.name,
    required this.role,
    required this.status,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : const AssetImage('assets/placeholder_user.png') as ImageProvider,
            ),
            SizedBox(height: 8.h),
            Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
            Text(role, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            const Spacer(),
            Text(status, style: TextStyle(fontSize: 12.sp, color: Colors.red)),
            SizedBox(height: 8.h),
            OutlinedButton(
              onPressed: onTap,
              child: Text('View Profile', style: TextStyle(fontSize: 12.sp)),
            ),
          ],
        ),
      ),
    );
  }
}