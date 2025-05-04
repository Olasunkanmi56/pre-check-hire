import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobSeekerHelpCenterScreen extends StatefulWidget {
  const JobSeekerHelpCenterScreen({super.key});

  @override
  State<JobSeekerHelpCenterScreen> createState() =>
      _JobSeekerHelpCenterScreenState();
}

class _JobSeekerHelpCenterScreenState extends State<JobSeekerHelpCenterScreen> {
  int selectedTab = 0;
  List<bool> _expanded = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Help Center",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
             Container(
              height: 55.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  _buildTabButton("FAQ", 0),
                  _buildTabButton("Contact Us", 1),
                ],
              ),
            ),
            selectedTab == 0 ? _buildFAQSection() : _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3282F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    List<String> questions = [
      "What is Precheck Hire?",
      "How do I subscribe to Precheck Hire?",
      "Is the Precheck Hire app free for employers?",
      "How do I unsubscribe?",
      "What features do I get after subscribing?",
    ];

    List<String> answers = List.generate(
      questions.length,
      (index) =>
          "Once your KYC verification is complete, go to the 'Subscription' section in the app, choose a suitable plan, and make the payment.",
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for help",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12.w,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.filter_list),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        ...List.generate(questions.length, (index) {
          return Card(
            margin: EdgeInsets.only(bottom: 10.h),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: Colors.white),
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
              childrenPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              title: Text(
                questions[index],
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              children: [
                Text(
                  answers[index],
                  style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactItem(
            icon: Icons.location_on_outlined,
            title: "Office Address",
            value: "6th Avenue, Wall Street, New York",
            actionLabel: "COPY",
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          _buildContactItem(
            icon: Icons.phone_outlined,
            title: "Phone Number",
            value: "+1 234 567 890",
            actionLabel: "CALL NOW",
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          _buildContactItem(
            icon: Icons.email_outlined,
            title: "Email Address",
            value: "help@precheckhire.com",
            actionLabel: "COPY",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.r, color: Colors.black54),
              SizedBox(width: 12.w),
              Expanded(child: Text(value, style: TextStyle(fontSize: 12.sp))),
              TextButton(
                onPressed: onTap,
                child: Text(
                  actionLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        actionLabel == "CALL NOW"
                            ? Colors.blue
                            : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
