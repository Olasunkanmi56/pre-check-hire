import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_login.dart';
import 'package:precheck_hire/screens/jobseeker_screens/jobseeker_sign_up.dart';
import 'package:precheck_hire/widget/on_oboarding.dart';

class OnOboardingJobSeekerScreenSignIn extends StatefulWidget {
  const OnOboardingJobSeekerScreenSignIn({super.key});

  @override
  State<OnOboardingJobSeekerScreenSignIn> createState() =>
      _OnOboardingJobSeekerScreenSignInState();
}

class _OnOboardingJobSeekerScreenSignInState
    extends State<OnOboardingJobSeekerScreenSignIn> {
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
                OnboardingCard(
                  imagePath: 'assets/images/onboarding/job.png',
                  title: 'Find Your Next Domestic Job Here!',
                  description:
                      'Register today to explore a range of domestic job opportunities, from entry-level to experienced roles',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobSeekerSignUpScreen(),
                      ),
                    );
                  },
                  btnText: 'Sign Up',
                  bottomText: 'Already have an account?',
                  bottomActionText: 'Sign in',
                  onBottomActionTap: () {
                    // Navigate to login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobSeekerLoginScreen(),
                      ),
                    );
                  },
                ),
                OnboardingCard(
                  imagePath: 'assets/images/onboarding/job.png',
                  title: 'Welcome Back, Job Seeker!!',
                  description:
                      'Continue with Precheck Hire to secure a job as a domestic worker',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobSeekerLoginScreen(),
                      ),
                    );
                  },
                  btnText: 'Sign In',
                  bottomText: 'Don’t have an account?',
                  bottomActionText: 'Sign up',
                  onBottomActionTap: () {
                    // Navigate to login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobSeekerSignUpScreen(),
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
