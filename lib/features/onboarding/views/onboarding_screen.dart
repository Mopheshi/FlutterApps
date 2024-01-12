import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/fading_text.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/media_res.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(ImageResource.todo),
              const WhiteSpce(height: 100),
              const FadingText(
                'ToDo with Riverpod',
                textAlign: TextAlign.center,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              const WhiteSpce(height: 10),
              Text(
                'Welcome!!! Do you want to clear tasks super fast with ToDo?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Arrow IconButton
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Ionicons.chevron_forward_circle),
                        iconSize: 30,
                        color: Colours.light,
                      ),
                      const WhiteSpce(width: 5),
                      const FadingText(
                        'Skip',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Placeholder(fallbackHeight: 20, fallbackWidth: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
