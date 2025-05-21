import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/employer_offer_detail.dart';
import 'package:precheck_hire/screens/employer_screens/joboffercard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EmployerJobOffersScreen extends StatefulWidget {
  const EmployerJobOffersScreen({super.key});

  @override
  State<EmployerJobOffersScreen> createState() =>
      _EmployerJobOffersScreenState();
}

class _EmployerJobOffersScreenState extends State<EmployerJobOffersScreen> {
  int selectedTabIndex = 0;
  int currentPage = 0;
  final int itemsPerPage = 6;

  final List<String> tabs = ['All', 'Rejected', 'Pending', 'Accepted'];
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> allOffers = List.generate(20, (index) {
    return {
      'title': 'House Keeper',
      'experience': '3yrs experience',
      'location': 'Oyo, Nigeria',
      'status': ['Rejected', 'Pending', 'Accepted', 'Accepted'][index % 4],
      'candidate': 'Adeayo Ilori',
      'daysAgo': '${index + 1} days ago',
      'imagePath': 'assets/images/home/luca.png',
    };
  });

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOffers =
        tabs[selectedTabIndex] == 'All'
            ? allOffers
            : allOffers
                .where((offer) => offer['status'] == tabs[selectedTabIndex])
                .toList();

    int totalPages = (filteredOffers.length / itemsPerPage).ceil();

    return Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Job Offers Sent',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context, rootNavigator: true).pop();
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        // ),
         automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFE3E3E7),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Container(
        color: Color(0xFFE3E3E7),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.r,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "Manage Job offer Sent",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              _buildScrollableTabBar(),
              SizedBox(height: 10.h),
              Center(
                child: SmoothPageIndicator(
                  controller: PageController(initialPage: selectedTabIndex),
                  count: tabs.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 4.h,
                    dotWidth: 8.w,
                    spacing: 10.w,
                    activeDotColor: _getTabColor(tabs[selectedTabIndex]),
                    dotColor: const Color.fromARGB(255, 84, 83, 83),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount:
                            filteredOffers
                                .skip(currentPage * itemsPerPage)
                                .take(itemsPerPage)
                                .length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final offer =
                              filteredOffers[currentPage * itemsPerPage +
                                  index];
                          return JobOfferCard(
                            title: offer['title'],
                            name: offer['candidate'],
                            timeAgo: offer['daysAgo'],
                            location: offer['location'],
                            status: offer['status'],
                            imagePath: offer['imagePath'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EmployerOfferDetailScreen(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Showing ${filteredOffers.isEmpty ? 0 : currentPage * itemsPerPage + 1} "
                          "- ${(currentPage + 1) * itemsPerPage > filteredOffers.length ? filteredOffers.length : (currentPage + 1) * itemsPerPage} "
                          "of ${filteredOffers.length}",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              onPressed:
                                  currentPage > 1
                                      ? () => setState(() => currentPage--)
                                      : null,
                              icon: Icon(
                                Icons.arrow_back,
                                size: 16,
                                color:
                                    currentPage > 1
                                        ? const Color(0xFF3b86fb)
                                        : Colors.grey,
                              ),
                              label: Text(
                                'Previous',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      currentPage > 1
                                          ? const Color(0xFF3b86fb)
                                          : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            TextButton(
                              onPressed:
                                  currentPage < totalPages
                                      ? () => setState(() => currentPage++)
                                      : null,
                              child: Row(
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          currentPage < totalPages
                                              ? const Color(0xFF3b86fb)
                                              : Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color:
                                        currentPage < totalPages
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        height: 40.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final isSelected = selectedTabIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                  currentPage = 0;
                  // _scrollController.jumpToPage(0);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? _getTabColor(tabs[index]) : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: _getTabColor(tabs[index]).withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ]
                          : [],
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getTabColor(String status) {
    switch (status) {
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      case 'Accepted':
        return Colors.green;
      case 'All':
      default:
        return Colors.blue;
    }
  }
}
