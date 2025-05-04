import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlacklistNotificationScreen extends StatefulWidget {
  const BlacklistNotificationScreen({super.key});

  @override
  State<BlacklistNotificationScreen> createState() =>
      _BlacklistNotificationScreenState();
}

class _BlacklistNotificationScreenState
    extends State<BlacklistNotificationScreen> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> notifications = [
    {
      "title":
          "Your candidate profile 'Quadri Fashola' has been updated successfully.",
      "date": "21 days ago",
      "description":
          "Your candidate profile was updated with the latest credentials and qualifications.",
      "icon": Icons.check_circle_outline,
      "color": Colors.blue,
      "read": true,
    },
    {
      "title": "You have received a job offer.",
      "date": "21 days ago",
      "description": "You received a job offer for a Senior Housekeeper role.",
      "icon": Icons.check_circle_outline,
      "color": Colors.green,
      "read": true,
    },
    {
      "title": "Your Profile has been blacklisted.",
      "date": "21 days ago",
      "description":
          "Your profile has been blacklisted due to unverified information.",
      "icon": Icons.cancel_outlined,
      "color": Colors.red,
      "read": false,
    },
    {
      "title": "You have received a new recommendation.",
      "date": "21 days ago",
      "description": "A previous employer has submitted a new recommendation.",
      "icon": Icons.check_circle_outline,
      "color": Colors.blue,
      "read": false,
    },
  ];

  late List<bool> _expandedStates;

  List<Map<String, dynamic>> get filteredNotifications {
    return selectedTab == 0
        ? notifications
        : notifications.where((n) => (n["read"] ?? false) == false).toList();
  }

  void _updateExpandedState() {
    _expandedStates = List<bool>.filled(filteredNotifications.length, false);
  }

  @override
  void initState() {
    super.initState();
    _updateExpandedState();
  }

  @override
  Widget build(BuildContext context) {
    final currentNotifications = filteredNotifications;

    // Ensure the expanded state is always in sync with the list
    if (_expandedStates.length != currentNotifications.length) {
      _updateExpandedState();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Notification",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            Container(
                height: 55.h,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3E3E7),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Row(
                  children: [
                    _tabButton("All Notifications", 0),
                    _tabButton("Unread (${notifications.where((n) => (n["read"] ?? false) == false).length})", 1),
                  ],
                ),
              ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: currentNotifications.length,
                itemBuilder: (context, index) {
                  final item = currentNotifications[index];
                  final isExpanded = _expandedStates[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedStates[index] = !_expandedStates[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.r,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: item["color"]?.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item["icon"],
                                  color: item["color"],
                                  size: 20.r,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"] ?? '',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      item["date"] ?? '',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 22.sp,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            SizedBox(height: 12.h),
                            Text(
                              item["description"] ?? '',
                              style: TextStyle(
                                fontSize: 13.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
            _updateExpandedState();
          });
        },
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3282F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
