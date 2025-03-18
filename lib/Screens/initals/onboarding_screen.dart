import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/_Configs/lang.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_Configs/size_config.dart';
import 'package:repair/_services/storage.dart';

import '../../Utils/backbutton.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'lottie': AppIamges.mechanica,
      'title': eng.onboardingheaidng1,
      'subtitle': eng.onboardingbody1,
    },
    {
      'lottie': AppIamges.mechanicb,
      'title': eng.onboardingheaidng2,
      'subtitle': eng.onboardingbody2,
    },
    {
      'lottie': AppIamges.mechanicc,
      'title': eng.onboardingheaidng3,
      'subtitle': eng.onboardingbody3,
    },
  ];

  // Navigate to Home after onboarding
  void completeOnboarding() async {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtils(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        AppBarButton(
          icon: Icons.close,
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
        ),
      ]),
      body: Stack(
        children: [
          // PageView for onboarding pages
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = _onboardingData[index];
              return buildPage(
                  page['lottie'], page['title'], page['subtitle'], context);
            },
          ),

          // Skip and Next buttons at the bottom
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                TextButton(
                  onPressed: completeOnboarding,
                  child: const Text('Skip'),
                ),
                // Next or Finish button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      completeOnboarding();
                    }
                  },
                  child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? 'Finish'
                        : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      String lottiePath, String title, String subtitle, BuildContext context) {
    final r = ResponsiveUtils(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Lottie Animation
        Lottie.asset(
          lottiePath,
          height: r.height(0.35), // Fixed height for animations
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text('Animation not found');
          },
        ),
        r.xl,
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        r.lg,
        Text(
          subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
