import 'package:flutter/material.dart';
import 'package:precheck_hire/screens/employer_screens/employer_login.dart';
import 'package:precheck_hire/screens/employer_screens/employer_sing_up.dart';
import 'package:precheck_hire/widget/on_oboarding.dart';

class OnOboardingEmployerScreenSignIn extends StatefulWidget {
  const OnOboardingEmployerScreenSignIn({super.key});

  @override
  State<OnOboardingEmployerScreenSignIn> createState() =>
      _OnOboardingEmployerScreenSignInState();
}

class _OnOboardingEmployerScreenSignInState
    extends State<OnOboardingEmployerScreenSignIn> {
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
                  imagePath: 'assets/images/onboarding/signin.png',
                  title: 'Discover Trusted Domestic Workers!',
                  description:
                      'Register today to explore domestic workers who are ready to assist you',
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (_, __, ___) => const EmployerSignUpScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
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
                      PageRouteBuilder(
                        pageBuilder:
                            (_, __, ___) => const EmployerLoginScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                OnboardingCard(
                  imagePath: 'assets/images/onboarding/signin.png',
                  title: 'Welcome Back,Employer!',
                  description:
                      'You can now request trusted domestic workers with just a few clicks.',
                  onPressed: () {},
                  btnText: 'Sign In',
                  bottomText: 'Don’t have an account?',
                  bottomActionText: 'Sign up',
                  onBottomActionTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder:
                    //         (_, __, ___) => const EmployerLoginScreen(),
                    //     transitionDuration: Duration.zero,
                    //     reverseTransitionDuration: Duration.zero,
                    //   ),
                    // );
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
