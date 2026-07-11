import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/ui/login_signup_screen.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = const [
    {
      'icon': Icons.confirmation_number_rounded,
      'title': 'Skip the Queue',
      'description':
          'Book your turn at any tailor digitally. No more '
          'waiting in crowded shops — reserve your spot from '
          'the comfort of your home.',
    },
    {
      'icon': Icons.home_rounded,
      'title': 'Premium Home Tailoring',
      'description':
          'Need a VIP experience? Request a professional '
          'tailor to visit your home for measurements and '
          'fittings at your convenience.',
    },
    {
      'icon': Icons.timeline_rounded,
      'title': 'Track Seamlessly',
      'description':
          'Follow every step of your order — from the queue '
          'to production to pickup. Get notified the moment '
          'your garment is ready.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLoginSignup() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginSignupScreen()),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 16),
                child: isLastPage
                    ? const SizedBox(height: 48)
                    : AppButton(
                        onPressed: _goToLoginSignup,
                        text: 'Skip',
                        type: AppButtonType.text,
                        isFullWidth: false,
                      ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPage(
                    icon: page['icon'] as IconData,
                    title: page['title'] as String,
                    description: page['description'] as String,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 28 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.accentGold
                              : AppColors.dividerGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  AppButton(
                    onPressed: isLastPage ? _goToLoginSignup : _nextPage,
                    text: isLastPage ? 'Get Started' : 'Next',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
