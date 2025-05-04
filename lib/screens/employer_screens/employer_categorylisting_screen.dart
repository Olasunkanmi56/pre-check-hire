import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({super.key});

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  int currentPage = 1;
  final int itemsPerPage = 10;

  final List<Map<String, dynamic>> categories = [
    {
      "label": "Chef",
      "count": 2,
      "color": Colors.amber,
      "icon": Icons.restaurant_menu,
    },
    {
      "label": "House Keeper",
      "count": 2,
      "color": Colors.green,
      "icon": Icons.cleaning_services,
    },
    {
      "label": "Driver",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.directions_car,
    },
    {
      "label": "Security",
      "count": 2,
      "color": Colors.blue,
      "icon": Icons.shield,
    },
    {
      "label": "Personal Assistant",
      "count": 2,
      "color": Colors.purple,
      "icon": Icons.person_pin_circle,
    },
    {
      "label": "Launderer",
      "count": 2,
      "color": Colors.orange,
      "icon": Icons.local_laundry_service,
    },
    {
      "label": "House Keeper",
      "count": 2,
      "color": Colors.green,
      "icon": Icons.cleaning_services,
    },
    {
      "label": "Driver",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.directions_car,
    },
    {
      "label": "Security",
      "count": 2,
      "color": Colors.blue,
      "icon": Icons.shield,
    },
    {
      "label": "Personal Assistant",
      "count": 2,
      "color": Colors.purple,
      "icon": Icons.person_pin_circle,
    },
    {
      "label": "Launderer",
      "count": 2,
      "color": Colors.orange,
      "icon": Icons.local_laundry_service,
    },
    {
      "label": "House Keeper",
      "count": 2,
      "color": Colors.green,
      "icon": Icons.cleaning_services,
    },
    {
      "label": "Driver",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.directions_car,
    },
    {
      "label": "Security",
      "count": 2,
      "color": Colors.blue,
      "icon": Icons.shield,
    },
    {
      "label": "Personal Assistant",
      "count": 2,
      "color": Colors.purple,
      "icon": Icons.person_pin_circle,
    },
    {
      "label": "Launderer",
      "count": 2,
      "color": Colors.orange,
      "icon": Icons.local_laundry_service,
    },
    {
      "label": "House Keeper",
      "count": 2,
      "color": Colors.green,
      "icon": Icons.cleaning_services,
    },
    {
      "label": "Driver",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.directions_car,
    },
    {
      "label": "Security",
      "count": 2,
      "color": Colors.blue,
      "icon": Icons.shield,
    },
    {
      "label": "Personal Assistant",
      "count": 2,
      "color": Colors.purple,
      "icon": Icons.person_pin_circle,
    },
    {
      "label": "Launderer",
      "count": 2,
      "color": Colors.orange,
      "icon": Icons.local_laundry_service,
    },
    {
      "label": "House Keeper",
      "count": 2,
      "color": Colors.green,
      "icon": Icons.cleaning_services,
    },
    {
      "label": "Driver",
      "count": 2,
      "color": Colors.red,
      "icon": Icons.directions_car,
    },
    {
      "label": "Security",
      "count": 2,
      "color": Colors.blue,
      "icon": Icons.shield,
    },
    {
      "label": "Personal Assistant",
      "count": 2,
      "color": Colors.purple,
      "icon": Icons.person_pin_circle,
    },
    {
      "label": "Launderer",
      "count": 2,
      "color": Colors.orange,
      "icon": Icons.local_laundry_service,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalPages = (categories.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end =
        (start + itemsPerPage) > categories.length
            ? categories.length
            : (start + itemsPerPage);
    final pageItems = categories.sublist(start, end);

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Browse by category',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                children:
                    pageItems.map((cat) => _buildCategoryCard(cat)).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${start + 1} - $end of ${categories.length}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
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
                    SizedBox(width: 16.w),
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
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category['icon'] ?? Icons.person,
            color: category['color'],
            size: 32.r,
          ),
          SizedBox(height: 8.h),
          Text(
            category['label'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            '${category['count']} Domestic Workers',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
          SizedBox(height: 3.h),
          Text(
            'Available',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
