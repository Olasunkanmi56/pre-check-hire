import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/joboffercard.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_offerdetail.dart';

class JobSeekerEmploymentScreen extends StatefulWidget {
  const JobSeekerEmploymentScreen({super.key});

  @override
  State<JobSeekerEmploymentScreen> createState() =>
      _JobSeekerEmploymentScreenState();
}

class _JobSeekerEmploymentScreenState extends State<JobSeekerEmploymentScreen> {
  int currentTabIndex = 1;
  int currentPage = 0;
  final int itemsPerPage = 6;

  List<Map<String, String>> directOffers = List.generate(8, (index) {
    return {
      'title': 'Home Cleaner',
      'candidate': index % 2 == 0 ? 'Temitope Ayetoro' : 'Jadeed Balogun',
      'daysAgo': '${index + 1} days ago',
      'location': 'Lagos, Kosofe',
      'status': index % 2 == 0 ? 'Active' : 'Pending',
      'imagePath': 'assets/images/home/luca.png',
    };
  });

  List<Map<String, String>> applicationOffers = List.generate(10, (index) {
    return {
      'title': 'Home Cleaner',
      'candidate':
          index % 3 == 0
              ? 'Temitope Ayetoro'
              : index % 3 == 1
              ? 'Jadeed Balogun'
              : 'Humphrey Chidi',
      'daysAgo': '${index + 1} days ago',
      'location': 'Lagos, Kosofe',
      'status':
          index % 3 == 0
              ? 'Active'
              : index % 3 == 1
              ? 'Pending'
              : 'Rejected',
      'imagePath': 'assets/images/home/luca.png',
    };
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedOffers =
        currentTabIndex == 0 ? directOffers : applicationOffers;

    final totalPages = (displayedOffers.length / itemsPerPage).ceil();

    final start = (currentPage * itemsPerPage).clamp(0, displayedOffers.length);
    final end = (start + itemsPerPage).clamp(start, displayedOffers.length);
    final currentItems = displayedOffers.sublist(start, end);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      'Employment',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Tab switcher
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentTabIndex = 0;
                            currentPage = 0;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color:
                                currentTabIndex == 0
                                    ? Colors.blue
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Direct',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  currentTabIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentTabIndex = 1;
                            currentPage = 0;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color:
                                currentTabIndex == 1
                                    ? Colors.blue
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'From Applications',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  currentTabIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Job cards grid
              Expanded(
                child: GridView.builder(
                  itemCount: currentItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final offer = currentItems[index];
                    return JobOfferCard(
                      title: offer['title']!,
                      name: offer['candidate']!,
                      timeAgo: offer['daysAgo']!,
                      location: offer['location']!,
                      status: offer['status']!,
                      imagePath: offer['imagePath']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobSeekerOfferDetailScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 12.h),

              // Pagination
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Showing ${currentItems.isEmpty ? 0 : start + 1}-$end of ${displayedOffers.length}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed:
                            currentPage > 0
                                ? () => setState(() => currentPage--)
                                : null,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 16,
                          color:
                              currentPage > 0
                                  ? const Color(0xFF3b86fb)
                                  : Colors.grey,
                        ),
                        label: Text(
                          'Previous',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color:
                                currentPage > 0
                                    ? const Color(0xFF3b86fb)
                                    : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      TextButton(
                        onPressed:
                            currentPage < totalPages - 1
                                ? () => setState(() => currentPage++)
                                : null,
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color:
                                    currentPage < totalPages - 1
                                        ? const Color(0xFF3b86fb)
                                        : Colors.grey,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color:
                                  currentPage < totalPages - 1
                                      ? const Color(0xFF3b86fb)
                                      : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
