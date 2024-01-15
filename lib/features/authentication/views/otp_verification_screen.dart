import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/media_res.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageResource.todo),
              const WhiteSpce(height: 26),
              // Basic manual implementation of OTP TextFields with a Row...
              // const Row(
              //   children: [
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //     Expanded(
              //       child: TextField(
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colours.light,
              //         ),
              //       ),
              //     ),
              //     WhiteSpce(width: 5),
              //   ],
              // ),
              // Auto implementation of OTP TextFields with PinPut library...
              Pinput(
                length: 6,
                onCompleted: (pin) {
                  // TODO: Firebase Verification
                },
                defaultPinTheme: PinTheme(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colours.light,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colours.darkBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
