import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_login.dart';
import 'package:precheck_hire/screens/blacklist_screens/blacklist_sign_up.dart';
import 'package:precheck_hire/widget/on_oboarding.dart';

class OnBoardingBlacklistSignInScreen extends StatefulWidget {
  const OnBoardingBlacklistSignInScreen({super.key});

  @override
  State<OnBoardingBlacklistSignInScreen> createState() =>
      _OnBoardingBlacklistSignInScreenState();
}

class _OnBoardingBlacklistSignInScreenState
    extends State<OnBoardingBlacklistSignInScreen> {
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
                  imagePath: 'assets/images/home/blacklist.png',
                  title: 'Protect Your Hiring Choices',
                  description:
                      'Sign Up and Gain Access to Our Blacklist of Domestic Workers.',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlacklistSignUpScreen(),
                      ),
                    );
                  },
                  btnText: 'Sign Up',
                  bottomText: 'Already have an account?',
                  bottomActionText: 'Sign in',
                  onBottomActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlacklistLoginScreen(),
                      ),
                    );
                  },
                ),
                OnboardingCard(
                  imagePath: 'assets/images/home/blacklist.png',
                  title: 'Welcome Back, Blacklist Viewer!',
                  description:
                      'Continue Reviewing Blacklisted Domestic Workers with Precheck Hire to Make Informed Decisions',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlacklistLoginScreen(),
                      ),
                    );
                  },
                  btnText: 'Sign In',
                  bottomText: 'Don’t have an account?',
                  bottomActionText: 'Sign up',
                  onBottomActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlacklistSignUpScreen(),
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
