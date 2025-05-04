import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/employer_offer_detail.dart';
import 'package:precheck_hire/screens/employer_screens/joboffercard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JobSeekerApplicationScreen extends StatefulWidget {
  const JobSeekerApplicationScreen({super.key});

  @override
  State<JobSeekerApplicationScreen> createState() =>
      _JobSeekerApplicationScreenState();
}

class _JobSeekerApplicationScreenState
    extends State<JobSeekerApplicationScreen> {
  int selectedTabIndex = 0;
  int currentPage = 0;
  final int itemsPerPage = 4;

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
      appBar: AppBar(
        title: Text(
          'My Job Applications',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black, // optional, for visibility
          ),
        ),
        leading: Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Center(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.r,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search for domestic workers",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 139, 138, 138),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 16.h,
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey.shade700,
                        ),
                        hintText: "Select your location",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade700,
                      ),
                      dropdownColor: Colors.white,
                      items:
                          ["Abia", "Adamawa", "Akwa Ibom", "Anambra"]
                              .map(
                                (state) => DropdownMenuItem(
                                  value: state,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    child: Text(
                                      state,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        // Handle selection
                      },
                      validator:
                          (value) =>
                              value == null ? 'Please select a location' : null,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3C8CE7),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                effect: WormEffect(
                  dotHeight: 4.h,
                  dotWidth: 8.w,
                  spacing: 10.w,
                  activeDotColor: _getTabColor(tabs[selectedTabIndex]),
                  dotColor: Colors.grey.shade300,
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
                            filteredOffers[currentPage * itemsPerPage + index];
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
    );
  }

  Widget _buildScrollableTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ), // outer padding for the whole tab bar
      child: SizedBox(
        height: 40.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          separatorBuilder:
              (_, __) => SizedBox(width: 12.w), // spacing between tabs
          itemBuilder: (context, index) {
            final isSelected = selectedTabIndex == index;
            return GestureDetector(
              onTap:
                  () => setState(() {
                    selectedTabIndex = index;
                    currentPage = 0;
                  }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? _getTabColor(tabs[index])
                          : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
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
