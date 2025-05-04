import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/employer_screens/employer_recommend_success.dart';
import 'package:precheck_hire/screens/employer_screens/employer_success_blacklist.dart';

class EmployerCandidateProfileScreen extends StatefulWidget {
  const EmployerCandidateProfileScreen({super.key});

  @override
  State<EmployerCandidateProfileScreen> createState() =>
      _EmployerCandidateProfileScreenState();
}

class _EmployerCandidateProfileScreenState
    extends State<EmployerCandidateProfileScreen> {
  bool isOverviewTab = true;

  final TextEditingController _blacklistCommentController =
      TextEditingController();
  final TextEditingController _recommendRelationshipController =
      TextEditingController();
  final TextEditingController _recommendCommentController =
      TextEditingController();

  @override
  void dispose() {
    _blacklistCommentController.dispose();
    _recommendRelationshipController.dispose();
    _recommendCommentController.dispose();
    super.dispose();
  }

  void _showBlacklistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Blacklist Candidate',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Comment ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: const [
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
                  controller: _blacklistCommentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Add your comment',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F3),
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
                          Navigator.pushReplacement(
                            dialogContext,
                            MaterialPageRoute(
                              builder: (_) => EmployerBlacklistSuccessScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF898A8D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRecommendDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Recommend Candidate',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.grey[300], thickness: 1),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Relationship',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _recommendRelationshipController,
                  decoration: InputDecoration(
                    hintText: 'Ex. Employer',
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _recommendCommentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'e.g He cooked so well and is also a caregiver',
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
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
                          Navigator.pushReplacement(
                            dialogContext,
                            MaterialPageRoute(
                              builder: (_) => EmployerRecommenfSuccessScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF898A8D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoItem(String title, String value, String svgPath) {
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
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(value, style: TextStyle(fontSize: 13.sp)),
              ],
            ),
          ),
          SvgPicture.asset(
            svgPath,
            width: 18.sp,
            height: 18.sp,
            color: Colors.black38, // optional
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : const Color(0xFF7d7f88),
            ),
          ),
        ),
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
          "Candidates Profile",
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
            SizedBox(height: 110.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    _buildTabButton(
                      "Profile",
                      !isOverviewTab,
                      () => setState(() => isOverviewTab = false),
                    ),
                    SizedBox(width: 8.w),
                    _buildTabButton(
                      "Overview",
                      isOverviewTab,
                      () => setState(() => isOverviewTab = true),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (!isOverviewTab)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildStat(
                          "5",
                          "Posted Jobs",
                          'assets/icons/p7.svg',
                          Color(0xFF3B82F6),
                        ),
                        SizedBox(width: 5.w),
                        _buildStat(
                          "3",
                          "Total Applications",
                          'assets/icons/p8.svg',
                          Color(0xFFFB0206),
                        ),
                        SizedBox(width: 5.w),
                        _buildStat(
                          "4",
                          "Notification",
                          'assets/icons/p9.svg',
                          Color.fromARGB(255, 59, 246, 90),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
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
                    isOverviewTab
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Profile Overview",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            _infoItem(
                              "Categories",
                              "Not specified",
                              "assets/icons/p5.svg",
                            ),
                            _infoItem(
                              "Experiences",
                              "6 years",
                              "assets/icons/p6.svg",
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoItem(
                              "About",
                              "Experienced professional cook",
                              "assets/icons/p1.svg",
                            ),
                            Divider(),
                            _infoItem(
                              "Education",
                              "No education information available",
                              "assets/icons/p2.svg",
                            ),
                            Divider(),
                            _infoItem(
                              "Recommendation",
                              "Ada is a well disciplined and well behaved driver",
                              "assets/icons/p3.svg",
                            ),
                          ],
                        ),
              ),
            ),
            if (!isOverviewTab) ...[
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showBlacklistDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: const Text(
                          "Blacklist",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showRecommendDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: const Text(
                          "Recommend",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label, String svgPath, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
            child: SvgPicture.asset(
              svgPath,
              width: 24.sp,
              height: 24.sp,
              color: Colors.black38, // optional
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
