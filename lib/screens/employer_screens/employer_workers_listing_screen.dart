import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_candidate_profile_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_candidate_profile.dart';
import 'package:precheck_hire/screens/employer_screens/employer_filter.dart';
import 'package:precheck_hire/widget/worker_profile_card.dart';

class EmployerExploreCandidatesScreen extends StatefulWidget {
  const EmployerExploreCandidatesScreen({super.key});

  @override
  State<EmployerExploreCandidatesScreen> createState() =>
      _EmployerExploreCandidatesScreenState();
}

class _EmployerExploreCandidatesScreenState
    extends State<EmployerExploreCandidatesScreen> {
  final int _itemsPerPage = 4;
  int _currentPage = 0;
  bool isBlacklistTab = false;

  final List<Map<String, dynamic>> _workers = List.generate(100, (index) {
    return {
      "name": "Worker ${index + 1}",
      "experience": (index % 10) + 1,
      "imagePath": "assets/images/home/luca.png",
      "isBlacklisted": index % 2 == 0, // Simulate some being blacklisted
    };
  });

  List<Map<String, dynamic>> get _filteredWorkers {
    return _workers.where((e) => e["isBlacklisted"] == isBlacklistTab).toList();
  }

  List<Map<String, dynamic>> get _currentPageWorkers {
    int start = _currentPage * _itemsPerPage;
    int end = start + _itemsPerPage;
    return _filteredWorkers.sublist(
      start,
      end > _filteredWorkers.length ? _filteredWorkers.length : end,
    );
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  void _goToNextPage() {
    if ((_currentPage + 1) * _itemsPerPage < _filteredWorkers.length) {
      setState(() => _currentPage++);
    }
  }

  void _switchTab(bool toBlacklist) {
    setState(() {
      isBlacklistTab = toBlacklist;
      _currentPage = 0;
    });
  }

  Widget _buildTabButton(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : const Color(0xFF7d7f88),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Text(
                              'Explore Candidates',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 48.w),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(7.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F3),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            _buildTabButton(
                              "Candidates",
                              !isBlacklistTab,
                              () => _switchTab(false),
                            ),
                            SizedBox(width: 8.w),
                            _buildTabButton(
                              "Blacklist",
                              isBlacklistTab,
                              () => _switchTab(true),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search your keywords',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF2F2F2),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const EmployerFilterScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/Iconfilter.svg',
                                width: 24.w,
                                height: 24.w,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      if (isBlacklistTab)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'Disclaimer: The blacklist is a user-generated resource provided for informational purposes only...',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 16.h),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9.w,
                        mainAxisSpacing: 9.h,
                        childAspectRatio: 0.70,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children:
                            _currentPageWorkers.map((worker) {
                              return WorkerCard(
                                name: worker["name"],
                                experience: worker["experience"],
                                imagePath: worker["imagePath"],
                                onViewProfile: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              EmployerCandidateProfileScreen(),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Showing: ${_currentPage * _itemsPerPage + 1} - ${(_currentPage + 1) * _itemsPerPage > _filteredWorkers.length ? _filteredWorkers.length : (_currentPage + 1) * _itemsPerPage} of ${_filteredWorkers.length}',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Row(
                              children: [
                                TextButton.icon(
                                  onPressed:
                                      _currentPage > 0
                                          ? _goToPreviousPage
                                          : null,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color:
                                        _currentPage > 0
                                            ? const Color(0xFF3B82F6)
                                            : Colors.grey,
                                    size: 14,
                                  ),
                                  label: Text(
                                    'Previous',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color:
                                          _currentPage > 0
                                              ? const Color(0xFF3B82F6)
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed:
                                      (_currentPage + 1) * _itemsPerPage <
                                              _filteredWorkers.length
                                          ? _goToNextPage
                                          : null,
                                  label: Icon(
                                    Icons.arrow_forward,
                                    color:
                                        (_currentPage + 1) * _itemsPerPage <
                                                _filteredWorkers.length
                                            ? const Color(0xFF3B82F6)
                                            : Colors.grey,
                                    size: 14,
                                  ),
                                  icon: Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color:
                                          (_currentPage + 1) * _itemsPerPage <
                                                  _filteredWorkers.length
                                              ? const Color(0xFF3B82F6)
                                              : Colors.grey,
                                    ),
                                  ),
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
          },
        ),
      ),
    );
  }
}
