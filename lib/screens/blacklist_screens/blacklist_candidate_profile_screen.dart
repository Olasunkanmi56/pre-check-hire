import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BlacklistCandidateProfileScreen extends StatefulWidget {
  const BlacklistCandidateProfileScreen({super.key});

  @override
  State<BlacklistCandidateProfileScreen> createState() =>
      _BlacklistCandidateProfileScreenState();
}

class _BlacklistCandidateProfileScreenState
    extends State<BlacklistCandidateProfileScreen> {
  bool isOverviewActive = true;

  void _showBlacklistDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Builder(
            builder:
                (dialogContext) => Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Blacklist Candidate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'Comment ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Add your comment',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: handle submit logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B82F6),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text('Submit'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                ); // <-- use dialogContext
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFF898A8D),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text('Close'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        );
      },
    );
  }

  Widget _tabButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6) : const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
          Text(
            value,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Candidate Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
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
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // 👈 Keeps the Row tightly wrapped
                          children: [
                            Text(
                              "Quadri Fashola",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 6.w), // optional spacing
                            SvgPicture.asset(
                              'assets/icons/warn.svg',
                              width: 24.sp,
                              height: 24.sp,
                              color: Color(0xFFFB0206),
                            ),
                          ],
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
            SizedBox(height: 110.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED), // light gray background
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    _tabButton("Profile", !isOverviewActive, () {
                      setState(() => isOverviewActive = false);
                    }),
                    SizedBox(width: 8.w),
                    _tabButton("Overview", isOverviewActive, () {
                      setState(() => isOverviewActive = true);
                    }),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child:
                  isOverviewActive
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile Overview",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Divider(color: Colors.grey[300], thickness: 1),
                          SizedBox(height: 12.h),
                          _infoRowWithIcon(
                            "Categories",
                            "Not specified",
                            "assets/icons/3.svg",
                          ),
                          _infoRowWithIcon(
                            "Experiences",
                            "6 years",
                            "assets/icons/5.svg",
                          ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRowWithIcon(
                            "About",
                            "Experienced professional driver",
                            "assets/icons/1.svg",
                          ),
                          Divider(color: Colors.grey[300], thickness: 1),
                          _infoRowWithIcon(
                            "Education",
                            "No education information available",
                            "assets/icons/grad.svg",
                          ),
                          Divider(color: Colors.grey[300], thickness: 1),
                          _infoRowWithIcon(
                            "Recommendation",
                            "Ada is a well disciplined and well behaved driver",
                            "assets/icons/p3.svg",
                          ),
                        ],
                      ),
            ),

            if (!isOverviewActive) ...[
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ElevatedButton(
                  onPressed: _showBlacklistDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text("Blacklist"),
                ),
              ),
            ],

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _infoRowWithIcon(String title, String value, String svgPath) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title:",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black, // blue-ish
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            svgPath,
            width: 24.sp,
            height: 24.sp,
            color: Colors.black38, // optional
          ),
        ],
      ),
    );
  }
}
