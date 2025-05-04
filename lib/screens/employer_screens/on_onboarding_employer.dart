import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/employer_screens/on_onboarding_employer_sign_in.dart';
import 'package:precheck_hire/widget/on_boarding_new.dart';

class OnOboardingEmployerScreen extends StatefulWidget {
  const OnOboardingEmployerScreen({super.key});

  @override
  State<OnOboardingEmployerScreen> createState() =>
      _OnOboardingEmployerScreenState();
}

class _OnOboardingEmployerScreenState extends State<OnOboardingEmployerScreen> {
  final PageController _pageController = PageController();

  void moveToNextPage() {
    final nextPage = _pageController.page!.toInt() + 1;

    if (nextPage < 3) {
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                OnboardingCardNew(
                  imagePath: 'assets/images/onboarding/iphone.png',
                  title: 'Hire Domestic Workers You Can Trust',
                  description:
                      'Find pre-screened and reliable workers for your home or business. Quick, easy, and secure',
                  onPressed:
                      () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                  bgColor: Color(0xFF3B82F6),
                  pageController: _pageController,
                  pageCount: 2,
                ),
                OnboardingCardNew(
                  imagePath: 'assets/images/onboarding/image2.png',
                  title: 'Why Employers Love PreCheck Hire',
                  bulletPoints: [
                    'Verified domestic workers',
                    'Fast & secure hiring process',
                    'Blacklist access for safer decisions',
                  ],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const OnOboardingEmployerScreenSignIn(),
                      ),
                    );
                  },
                  bgColor: Color(0xFFe2e2e2),
                  pageController: _pageController,
                  pageCount: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
