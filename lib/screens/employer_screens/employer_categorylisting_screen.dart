import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/models/category.model.dart';
import 'package:precheck_hire/store/modules/miscellaneous.module.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({super.key});

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  int currentPage = 1;
  final int itemsPerPage = 10;

  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final data = await MiscellaneousModule().fetchDomesticCategories();
      setState(() {
        categories = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (e.g. show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (categories.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage) > categories.length ? categories.length : (start + itemsPerPage);
    final pageItems = categories.sublist(start, end);

    return Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Browse by category',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      children: pageItems.map(_buildCategoryCard).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${start + 1} - $end of ${categories.length}',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: currentPage > 1 ? () => setState(() => currentPage--) : null,
                            icon: Icon(Icons.arrow_back, size: 16, color: currentPage > 1 ? const Color(0xFF3b86fb) : Colors.grey),
                            label: Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: currentPage > 1 ? const Color(0xFF3b86fb) : Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          TextButton(
                            onPressed: currentPage < totalPages ? () => setState(() => currentPage++) : null,
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: currentPage < totalPages ? const Color(0xFF3b86fb) : Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 16, color: currentPage < totalPages ? const Color(0xFF3b86fb) : Colors.grey),
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

  Widget _buildCategoryCard(Category category) {
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
            getIconForCategory(category.name),
            color: getColorForCategory(category.name),
            size: 32.r,
          ),
          SizedBox(height: 8.h),
          Text(
            category.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            '${category.candidateCount} Domestic Workers',
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

  IconData getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'chef':
        return Icons.restaurant_menu;
      case 'housekeeper':
        return Icons.cleaning_services;
      case 'driver':
        return Icons.directions_car;
      case 'security personnel':
        return Icons.shield;
      case 'personal assistance':
        return Icons.person_pin_circle;
      case 'laundrers':
        return Icons.local_laundry_service;
      case 'nanny':
        return Icons.child_friendly;
      case 'gardener':
        return Icons.grass;
      case 'butler':
        return Icons.room_service;
      case 'cleaner':
        return Icons.cleaning_services;
      default:
        return Icons.person;
    }
  }

  Color getColorForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'chef':
        return Colors.amber;
      case 'housekeeper':
        return Colors.green;
      case 'driver':
        return Colors.red;
      case 'security personnel':
        return Colors.blue;
      case 'personal assistance':
        return Colors.purple;
      case 'laundrers':
        return Colors.orange;
      case 'nanny':
        return Colors.pink;
      case 'gardener':
        return Colors.teal;
      case 'butler':
        return Colors.indigo;
      case 'cleaner':
        return Colors.brown;
      default:
        return Colors.blueGrey;
    }
  }
}