import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:precheck_hire/screens/employer_screens/blacklist_card.dart';

class BlacklistScreen extends StatefulWidget {
  const BlacklistScreen({super.key});

  @override
  State<BlacklistScreen> createState() => _BlacklistScreenState();
}

class _BlacklistScreenState extends State<BlacklistScreen> {
  int currentPage = 0;
  final int itemsPerPage = 6;

  final List<Map<String, String>> candidates = List.generate(
    20,
    (index) => {
      'name': 'Candidate ${index + 1}',
      'role': 'Role ${index + 1}',
      'status': 'Not recommended',
      'image': '', // use empty for placeholder
    },
  );

  List<Map<String, String>> get paginatedCandidates {
    int start = currentPage * itemsPerPage;
    int end = (start + itemsPerPage).clamp(0, candidates.length);
    return candidates.sublist(start, end);
  }

  // void showProfileDialog(String name) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (_) => AlertDialog(
  //           title: Text('$name\'s Profile'),
  //           content: const Text('More detailed profile info goes here.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Close'),
  //             ),
  //           ],
  //         ),
  //   );
  // }

  void nextPage() {
    if ((currentPage + 1) * itemsPerPage < candidates.length) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blacklisted')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // RED WARNING
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber, color: Colors.white),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        children: [
                          const TextSpan(
                            text:
                                'Disclaimer\nThe blacklist is a user-generated resource provided for informational purposes only... ',
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        title: const Text('Disclaimer'),
                                        content: const Text(
                                          'The blacklist is a user-generated resource provided for informational purposes only. '
                                          'Please exercise your own judgment carefully when using it. '
                                          'The creators and platform do not verify the accuracy or validity of the content. '
                                          'Use of this information is at your own risk.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                'See more',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Search & Filter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your keywords',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Grid of Cards
            Expanded(
              child: GridView.builder(
                itemCount: paginatedCandidates.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final candidate = paginatedCandidates[index];
                  return BlacklistCandidateCard(
                    name: candidate['name']!,
                    role: candidate['role']!,
                    status: candidate['status']!,
                    imageUrl: candidate['image']!,
                    onTap: () {},
                  );
                },
              ),
            ),

            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${currentPage * itemsPerPage + 1} of ${candidates.length}',
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: previousPage,
                      child: const Text('Previous'),
                    ),
                    TextButton(onPressed: nextPage, child: const Text('Next')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Reusable Card
