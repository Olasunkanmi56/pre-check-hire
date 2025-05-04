import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/jobseeker_screens/onboarding_jobseeker_sign_in.dart';
import 'package:precheck_hire/widget/on_boarding_new.dart';

class OnOboardingJobSeekerScreen extends StatefulWidget {
  const OnOboardingJobSeekerScreen({super.key});

  @override
  State<OnOboardingJobSeekerScreen> createState() =>
      _OnOboardingJobSeekerScreenState();
}

class _OnOboardingJobSeekerScreenState
    extends State<OnOboardingJobSeekerScreen> {
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
                  imagePath: 'assets/images/onboarding/job1.png',
                  title: 'Find Your Next Job Faster',
                  description:
                      'Connect with trusted employers looking for skilled domestic workers like you.',
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
                  imagePath: 'assets/images/onboarding/job2.png',
                  title: 'Get Hired in 4 Easy Steps!',
                  bulletPoints: [
                    ' Sign Up – Create your profile in minutes.',
                    'Verify Your KYC',
                    'Subscribe – Choose a plan to access premium job listings.',
                    'Apply & Get Hired',
                  ],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                const OnOboardingJobSeekerScreenSignIn(),
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
