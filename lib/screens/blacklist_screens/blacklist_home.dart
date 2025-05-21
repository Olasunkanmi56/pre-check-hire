import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_candidate_profile_screen.dart';
import 'package:precheck_hire/screens/employer_screens/employer_filter.dart';
import 'package:precheck_hire/widget/worker_profile_card.dart';

class BlacklistHomeScreen extends StatefulWidget {
  const BlacklistHomeScreen({super.key});

  @override
  State<BlacklistHomeScreen> createState() => _BlacklistHomeScreenState();
}

class _BlacklistHomeScreenState extends State<BlacklistHomeScreen> {
  final int _itemsPerPage = 6;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _blacklistedWorkers = List.generate(100, (
    index,
  ) {
    return {
      "name": "Worker ${index + 1}",
      "experience": (index % 10) + 1,
      "imagePath": "assets/images/home/luca.png",
    };
  });

  List<Map<String, dynamic>> get _currentPageWorkers {
    int start = _currentPage * _itemsPerPage;
    int end = start + _itemsPerPage;
    return _blacklistedWorkers.sublist(
      start,
      end > _blacklistedWorkers.length ? _blacklistedWorkers.length : end,
    );
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  void _goToNextPage() {
    if ((_currentPage + 1) * _itemsPerPage < _blacklistedWorkers.length) {
      setState(() => _currentPage++);
    }
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
                      // Header
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Blacklisted',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Search & filter
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
                                  vertical: 0,
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

                      // Disclaimer
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.red,
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
                                'Disclaimer: The blacklist is a user-generated resource provided for informational purposes only. Precheck Hire does not endorse or verify the accuracy of the entries. Users are encouraged to exercise their own judgment and due diligence when making decisions based on this information. Precheck Hire is not liable for any actions taken as a result of using the blacklist.',
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

                      // Worker Grid
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
                                              BlacklistCandidateProfileScreen(),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                      ),

                      // Pagination
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Showing: ${_currentPage * _itemsPerPage + 1} - ${(_currentPage + 1) * _itemsPerPage > _blacklistedWorkers.length ? _blacklistedWorkers.length : (_currentPage + 1) * _itemsPerPage} of ${_blacklistedWorkers.length}',
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
                                              _blacklistedWorkers.length
                                          ? _goToNextPage
                                          : null,
                                  label: Icon(
                                    Icons.arrow_forward,
                                    color:
                                        (_currentPage + 1) * _itemsPerPage <
                                                _blacklistedWorkers.length
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
                                                  _blacklistedWorkers.length
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
