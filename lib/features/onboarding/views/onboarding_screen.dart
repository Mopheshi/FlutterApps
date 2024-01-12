import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/onboarding/views/widgets/first_page.dart';
import 'package:todo_app/features/onboarding/views/widgets/second_page.dart';

import '../../../core/common/widgets/fading_text.dart';
import '../../../core/common/widgets/white_space.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.darkBackground,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [FirstPage(), SecondPage()],
            ),

            // const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.bounceInOut,
                        );
                      },
                      child: const Row(
                        children: [
                          // Button with arrow icon
                          Icon(
                            Ionicons.chevron_forward_circle,
                            size: 30,
                            color: Colours.light,
                          ),
                          WhiteSpce(width: 5),
                          FadingText(
                            'Skip',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Swipe Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      spacing: 10,
                      dotColor: Colours.yellow.withOpacity(0.5),
                      activeDotColor: Colours.light,
                    ),
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
