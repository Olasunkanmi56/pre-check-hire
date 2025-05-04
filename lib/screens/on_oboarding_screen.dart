import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/blacklist_screens/on_onboarding_blacklist.dart';
import 'package:precheck_hire/screens/employer_screens/on_onboarding_employer.dart';
import 'package:precheck_hire/screens/jobseeker_screens/on_onboarding_jobseeker.dart';
import 'package:precheck_hire/widget/on_oboarding.dart';

class OnOboardingScreen extends StatefulWidget {
  const OnOboardingScreen({super.key});

  @override
  State<OnOboardingScreen> createState() => _OnOboardingScreenState();
}

class _OnOboardingScreenState extends State<OnOboardingScreen> {
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
                // OnboardingCard(
                //   imagePath: 'assets/images/onboarding/oboarding-image2.png',
                //   title: 'Hire Trustworthy Domestic Workers',
                //   description:
                //       'This service has been helping families and households find reliable domestic helpers over time.',
                //   onPressed: moveToNextPage,
                //   btnText: 'Get Started',
                // ),
                // OnboardingCard(
                //   imagePath: 'assets/images/onboarding/onboarding-image1.png',
                //   title: 'Hire Trustworthy Domestic Workers',
                //   description:
                //       'This service has been helping families and households find reliable domestic helpers over time.',
                //   onPressed: moveToNextPage,
                //   btnText: 'Get Started',
                // ),
                OnboardingCard(
                  imagePath: 'assets/images/onboarding/oboarding-image2.png',
                  title: 'Welcome to Precheck Hire!',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnOboardingEmployerScreen(),
                      ),
                    );
                  },
                  btnText: 'Employer',
                  optionalBtn1Text: "Job Seeker",
                  optionalBtn1Pressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const OnOboardingJobSeekerScreen(),
                      ),
                    );
                  },
                  optionalBtn2Text: "Blacklist Viewer",
                  optionalBtn2Pressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const OnOboardingBlacklistScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
