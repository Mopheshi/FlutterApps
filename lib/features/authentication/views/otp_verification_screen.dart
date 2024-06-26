import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/features/authentication/controller/authentication_controller.dart';

import '../../../core/utils/core_utils.dart';

class OTPVerificationScreen extends ConsumerWidget {
  final String verificationId;

  const OTPVerificationScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageResource.todo),
              const WhiteSpce(height: 26),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        otp: pin,
                        verificationId: verificationId,
                      );
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
