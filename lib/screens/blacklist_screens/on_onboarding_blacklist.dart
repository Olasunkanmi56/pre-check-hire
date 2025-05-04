import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/blacklist_screens/onboarding_blacklist_signup.dart';
import 'package:precheck_hire/widget/on_boarding_new.dart';

class OnOboardingBlacklistScreen extends StatefulWidget {
  const OnOboardingBlacklistScreen({super.key});

  @override
  State<OnOboardingBlacklistScreen> createState() =>
      _OnOboardingBlacklistScreenState();
}

class _OnOboardingBlacklistScreenState
    extends State<OnOboardingBlacklistScreen> {
  final PageController _pageController = PageController();

  void moveToNextPage() {
    final nextPage = _pageController.page!.toInt() + 1;

    if (nextPage < 2) {
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
                  imagePath: 'assets/images/onboarding/blacklist1.png',
                  title: 'Make Safer Hiring Decisions',
                  description:
                      'Gain exclusive access to verified records of blacklisted domestic workers. Protect your home and loved ones with informed hiring choices.',
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
                  imagePath: 'assets/images/onboarding/blacklist1.png',
                  title: 'Credibility',
                  description:
                      'Join other smart employers using PreCheck Hire for secure recruitment.',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                const OnBoardingBlacklistSignInScreen(),
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
