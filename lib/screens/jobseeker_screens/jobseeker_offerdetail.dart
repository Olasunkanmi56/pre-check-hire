import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class JobSeekerOfferDetailScreen extends StatefulWidget {
  const JobSeekerOfferDetailScreen({super.key});

  @override
  State<JobSeekerOfferDetailScreen> createState() =>
      _JobSeekerOfferDetailScreenState();
}

class _JobSeekerOfferDetailScreenState
    extends State<JobSeekerOfferDetailScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: Text(
          "Offer Details",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Main Content
              Column(
                children: [
                  SizedBox(height: 20.h), // Space for floating image
                  Container(
                    width: double.infinity,
                    height: 105.h,
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
                  SizedBox(height: 120.h), // Space under the floating avatar
                  // Tab Buttons
                  Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3E3E7),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        _tabButton("About Job", 0),
                        _tabButton("Offer Details", 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Tab Content
                  selectedTab == 0 ? _jobRoleSection() : _jobInfoSection(),
                  SizedBox(height: 40.h),
                ],
              ),

              // Floating Profile
              Positioned(
                top: 90.h,
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
                    SizedBox(height: 8.h),
                    Text(
                      "Quadri Fashola",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Senior House Keeper",
                      style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3282F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _jobRoleSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoRow("Name", "Quadri Fashola", 'assets/icons/r1.svg'),
          _infoRow("Job Type", "Full Time",'assets/icons/r2.svg'),
          _infoRow("Location", "Lagos, Kosofe",  'assets/icons/MapPin.svg'),
          _infoRow("Experience", "2 years", 'assets/icons/award.svg'),
          _infoRow("No of Recommendations", "3", 'assets/icons/grad.svg'),
          _infoRow("Salary", "₦60,000 - ₦70,000", 'assets/icons/wallet.svg'),
          _infoRow("Date Posted", "8th November, 2024", 'assets/icons/Time.svg'),
        ],
      ),
    );
  }

  Widget _jobInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Offer Details", style: _sectionTitleStyle()),
          Divider(color: Colors.grey.shade300, thickness: 1),
          SizedBox(height: 10.h),
          Text(
            "You should have 2 years of experience in domestic work. You will be paid ₦60,000 Naira per month. We're looking for someone hardworking and honest.",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () => _showApproveDialog(),
                  child: Text("APPROVE", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () => _showRejectDialog(),
                  child: Text("REJECT", style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

   Widget _infoRow(String title, String value, String svgIconPath) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF0D0140),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    color: Color(0xFF3b82f6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            svgIconPath,
            width: 19.sp,
            height: 19.sp,
            color: Colors.black, // optional: set the color if needed
          ),
        ],
      ),
    );
  }


  // Widget _infoParagraph(String title, String content) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "$title:",
  //         style: TextStyle(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 14.sp,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       SizedBox(height: 4.h),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Icon(Icons.arrow_forward, size: 12, color: Colors.black54),
  //           SizedBox(width: 5.w),
  //           Text(
  //             content,
  //             style: TextStyle(fontSize: 13.sp, color: Colors.black54),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  TextStyle _sectionTitleStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15.sp,
      color: Colors.black87,
    );
  }

  void _showApproveDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm Approve",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Are you sure you want to approve this offer?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle approval action
                         
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          "Approve",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
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

  void _showRejectDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm Reject",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Are you sure you want to reject this offer?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Handle rejection action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Closes the dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
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
}
