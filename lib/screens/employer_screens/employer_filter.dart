import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployerFilterScreen extends StatefulWidget {
  const EmployerFilterScreen({super.key});

  @override
  State<EmployerFilterScreen> createState() => _EmployerFilterScreenState();
}

class _EmployerFilterScreenState extends State<EmployerFilterScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? selectedState;
  String? selectedLGA;
  String? selectedJobType;

  final List<String> states = ['Lagos', 'Abuja', 'Kano'];
  final List<String> lgas = ['Ikeja', 'Surulere', 'Gwagwalada'];
  final List<String> jobTypes = ['Nanny', 'Cleaner', 'Driver'];

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      selectedState = null;
      selectedLGA = null;
      selectedJobType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Filter",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Domestic workers',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search keywords',
                prefixIcon: const Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                filled: true,
                fillColor: const Color(0xFFF7F7F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildDropdown('State', states, selectedState, (value) {
              setState(() {
                selectedState = value;
              });
            }),
            SizedBox(height: 16.h),
            _buildDropdown('LGA', lgas, selectedLGA, (value) {
              setState(() {
                selectedLGA = value;
              });
            }),
            SizedBox(height: 16.h),
            _buildDropdown('Job Types', jobTypes, selectedJobType, (value) {
              setState(() {
                selectedJobType = value;
              });
            }),
            SizedBox(height: 50.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5EEFF),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      minimumSize: Size(double.infinity, 48.h),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply logic
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      minimumSize: Size(double.infinity, 48.h),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          hint: Text('Select all $label'),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F7F8),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
