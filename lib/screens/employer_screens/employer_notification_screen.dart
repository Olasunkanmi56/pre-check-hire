import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/models/notification.model.dart';
import 'package:precheck_hire/store/modules/miscellaneous.module.dart';
import 'package:intl/intl.dart';

class EmployerNotificationScreen extends StatefulWidget {
  const EmployerNotificationScreen({super.key});

  @override
  State<EmployerNotificationScreen> createState() =>
      _EmployerNotificationScreenState();
}

class _EmployerNotificationScreenState
    extends State<EmployerNotificationScreen> {
  int selectedTab = 0;
  List<UserNotification> allNotifications = [];
  List<UserNotification> displayedNotifications = [];
  List<bool> _expandedStates = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final service = MiscellaneousModule();
      final notifications = await service.fetchUserNotifications();
      setState(() {
        allNotifications = notifications;
        applyFilters();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Optionally show error UI
    }
  }

  void applyFilters() {
    final filtered = selectedTab == 0
        ? allNotifications
        : allNotifications.where((n) => !n.read).toList();

    if (searchQuery.isNotEmpty) {
      displayedNotifications = filtered
          .where((n) => n.message.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      displayedNotifications = filtered;
    }

    _expandedStates = List.generate(displayedNotifications.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Notification",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                        _tabButton(
                          "Unread (${allNotifications.where((n) => !n.read).length})",
                          1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        applyFilters();
                      });
                    },
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
                    child: displayedNotifications.isEmpty
                        ? const Center(child: Text("No notifications found"))
                        : ListView.builder(
                            itemCount: displayedNotifications.length,
                            itemBuilder: (context, index) {
                              final item = displayedNotifications[index];
                              final isExpanded = _expandedStates[index];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _expandedStates[index] = !isExpanded;
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
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            item.read ? Icons.notifications : Icons.notifications_active,
                                            color: item.read ? Colors.grey : Colors.blue,
                                            size: 24.r,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.message,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  DateFormat('dd MMM yyyy, hh:mm a')
                                                      .format(item.createdAt),
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
                                          item.message,
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
            applyFilters();
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
