import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/round_button.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/features/authentication/app/country_code_provider.dart';
import 'package:todo_app/features/authentication/controller/authentication_controller.dart';
import 'package:todo_app/features/authentication/repository/authentication_repository.dart';

import '../../../core/res/colours.dart';
import '../../../core/res/media_res.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );

    final code = ref.watch(countryCodeProvider);

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
                readOnly: code == null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colours.light,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (code) {
                            ref
                                .read(countryCodeProvider.notifier)
                                .changeCountry(code);
                          },
                          countryListTheme: CountryListThemeData(
                            backgroundColor: Colours.darkBackground,
                            bottomSheetHeight:
                                MediaQuery.of(context).size.height * 0.6,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            inputDecoration: InputDecoration(
                                hintText: 'Search country...',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colours.lightGrey,
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Search country'),
                            searchTextStyle:
                                GoogleFonts.poppins(color: Colours.light),
                            textStyle:
                                GoogleFonts.poppins(color: Colours.light),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: code == null ? 6.h : 1.5.h),
                        child: Text(
                          code == null
                              ? 'Pick country...'
                              : '${code.flagEmoji} +${code.phoneCode}  ',
                          style: GoogleFonts.poppins(
                            fontSize: code == null ? 13 : 18,
                            color: code == null
                                ? Colors.lightBlue
                                : Colours.darkBackground,
                            fontWeight: code == null
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                  AuthenticationController(AuthenticationRepository(
                    auth: FirebaseAuth.instance,
                  )).sentOTP(
                    context: context,
                    phoneNumber: 'phoneNumber',
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
