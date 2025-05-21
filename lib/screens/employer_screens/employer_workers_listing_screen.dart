import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:precheck_hire/models/candidate.model.dart';
import 'package:precheck_hire/screens/employer_screens/employer_candidate_profile.dart';
import 'package:precheck_hire/screens/employer_screens/employer_filter.dart';
import 'package:precheck_hire/store/modules/miscellaneous.module.dart';
import 'package:precheck_hire/widget/worker_profile_card.dart';

class EmployerExploreCandidatesScreen extends StatefulWidget {
  final String? initialSearchText;
  final String? initialSelectedState;
  const EmployerExploreCandidatesScreen({
    super.key,
    this.initialSearchText,
    this.initialSelectedState,
  });

  @override
  State<EmployerExploreCandidatesScreen> createState() =>
      _EmployerExploreCandidatesScreenState();
}

class _EmployerExploreCandidatesScreenState
    extends State<EmployerExploreCandidatesScreen> {
  final int _itemsPerPage = 4;
  List<Candidate> _allCandidates = [];
  bool _isLoading = true;
  int _currentPage = 0;
  bool isBlacklistTab = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _searchKeyword;
  String? _selectedState;
  String? _selectedLGA;
  String? _selectedJobType;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.initialSearchText ?? '';
    _searchController.text = _searchQuery;
    _selectedState = widget.initialSelectedState;
    //  _loadCandidate();
    _loadCandidates();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Future<void> _loadCandidate() async {
  //   try {
  //     final data =
  //         await MiscellaneousModule().getCandidateDetails(widget.candidateId);
  //     setState(() {
  //       _candidate = data;
  //       _loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _error = e.toString();
  //       _loading = false;
  //     });
  //   }
  // }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _searchKeyword = filters['search'];
      _selectedState = filters['state'];
      _selectedLGA = filters['lga'];
      _selectedJobType = filters['jobType'];
      _currentPage = 0;
      _isLoading = true;
    });

    _fetchCandidates();
  }

  Future<void> _fetchCandidates() async {
    try {
      final candidates = await MiscellaneousModule().fetchAllCandidates(
        search: _searchKeyword,
        state: _selectedState,
        lga: _selectedLGA,
        jobType: _selectedJobType,
      );

      setState(() {
        _allCandidates = candidates;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching filtered candidates: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadCandidates() async {
    try {
      final candidates = await MiscellaneousModule().fetchAllCandidates();
      setState(() {
        _allCandidates = candidates;
        print("help");
        print(candidates);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching candidates: $e');
      setState(() => _isLoading = false);
    }
  }

  List<Candidate> get _filteredWorkers {
    final filtered =
        _allCandidates.where((c) => c.isBlacklisted == isBlacklistTab).toList();
    if (_searchQuery.isEmpty) return filtered;
    return filtered
        .where(
          (c) => c.fullName.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<Candidate> get _currentPageWorkers {
    int start = _currentPage * _itemsPerPage;
    int end = start + _itemsPerPage;
    if (start >= _filteredWorkers.length) return [];
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
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
                                  // textAlign: TextAlign.center,
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
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                      _currentPage =
                                          0; // Reset to first page on new search
                                    });
                                  },
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
                                onTap: () async {
                                  final filters = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => const EmployerFilterScreen(),
                                    ),
                                  );

                                  if (filters != null && mounted) {
                                    _applyFilters(filters);
                                  }
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (isBlacklistTab) ...[
                            SizedBox(height: 12.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC107),
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
                          ],
                          SizedBox(height: 16.h),
                          _currentPageWorkers.isEmpty
                              ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.h),
                                  child: Text(
                                    'No candidates found.',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              )
                              : GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 9.w,
                                mainAxisSpacing: 9.h,
                                childAspectRatio: 0.70,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children:
                                    _currentPageWorkers.map((candidate) {
                                      return WorkerCard(
                                        name: candidate.fullName,
                                        experience:
                                            candidate.yearsOfExperience ?? 0,

                                        imagePath:
                                            candidate.profileImageUrl ??
                                            'assets/images/default_profile.png',
                                        onViewProfile: () {
                                          if (candidate.id != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) =>
                                                        EmployerCandidateProfileScreen(
                                                          candidateId:
                                                              candidate.id!,
                                                        ),
                                              ),
                                            );
                                          }
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
                                        size: 14,
                                        color:
                                            _currentPage > 0
                                                ? const Color(0xFF3B82F6)
                                                : Colors.grey,
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
                                      icon: Text(
                                        'Next',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color:
                                              (_currentPage + 1) *
                                                          _itemsPerPage <
                                                      _filteredWorkers.length
                                                  ? const Color(0xFF3B82F6)
                                                  : Colors.grey,
                                        ),
                                      ),
                                      label: Icon(
                                        Icons.arrow_forward,
                                        size: 14,
                                        color:
                                            (_currentPage + 1) * _itemsPerPage <
                                                    _filteredWorkers.length
                                                ? const Color(0xFF3B82F6)
                                                : Colors.grey,
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
