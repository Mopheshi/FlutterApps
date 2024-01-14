import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/round_button.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/features/authentication/views/otp_verification_screen.dart';

import '../../../core/res/colours.dart';
import '../../../core/res/media_res.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            // physics: const PageScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              Image.asset(ImageResource.todo),
              const WhiteSpce(height: 20),
              Text(
                'Please enter your phone number to get the verification code...',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colours.light,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const WhiteSpce(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colours.darkBackground,
                  fontWeight: FontWeight.bold,
                ),
                // cursorColor: Colors.blue, can be changed here or in the main.dart ThemeData...
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colours.light,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
              const WhiteSpce(height: 30),
              RoundButton(
                text: 'Send Code',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OTPVerificationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
