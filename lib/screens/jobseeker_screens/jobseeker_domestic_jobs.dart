import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/joboffercard.dart';

class DomesticJobScreen extends StatefulWidget {
  const DomesticJobScreen({super.key});

  @override
  State<DomesticJobScreen> createState() => _DomesticJobScreenState();
}

class _DomesticJobScreenState extends State<DomesticJobScreen> {
  int currentPage = 0;
  final int itemsPerPage = 4;

  final List<Map<String, String>> allOffers = List.generate(8, (index) {
    return {
      'title': index == 3 ? 'Chef Needed' : 'Home Cleaner',
      'candidate': index % 2 == 0 ? 'Jadeed Balogun' : 'Temitope Ayetoro',
      'daysAgo': index == 3 ? '8 days ago' : '21 days ago',
      'location': 'Lagos, Kosofe',
      'status': 'Full-time',
      'imagePath': 'assets/images/home/luca.png',
    };
  });

  int get totalPages => (allOffers.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    // Pagination logic
    final start = currentPage * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, allOffers.length);
    final currentItems = allOffers.sublist(start, end);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Domestic Jobs',
          overflow: TextOverflow.ellipsis,
          
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search & location section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.r),
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
                      SizedBox(height: 12.h),
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
                                value == null
                                    ? 'Please select a location'
                                    : null,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Search",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Job cards (paginated)
                GridView.builder(
                  itemCount: currentItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.h,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 0.80,
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
                      onTap: () {},
                    );
                  },
                ),

                SizedBox(height: 16.h),

                // Pagination section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Showing ${allOffers.isEmpty ? 0 : start + 1} - $end of ${allOffers.length}",
                        style: TextStyle(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                              fontWeight: FontWeight.w400,
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
                                  fontWeight: FontWeight.w400,
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
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
