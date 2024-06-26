import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/authentication/views/otp_verification_screen.dart';
import 'package:todo_app/features/todo/views/home_screen.dart';

final authRepoProvider = Provider((ref) => AuthenticationRepository(
      auth: FirebaseAuth.instance,
    ));

class AuthenticationRepository {
  final FirebaseAuth auth;

  const AuthenticationRepository({
    required this.auth,
  });

  Future<void> sendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        CoreUtils.showSnackBar(
            context: context,
            message: '${exception.code}: ${exception.message}');
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    void showSnackBar(String message) => CoreUtils.showSnackBar(
          context: context,
          message: message,
        );

    try {
      final navigator = Navigator.of(context);
      final userCredential =
          await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      ));

      if (userCredential.user != null) {
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        showSnackBar('Error occured, failed to sign up user...');
      }
    } on FirebaseException catch (e) {
      showSnackBar('${e.code}: ${e.message}');
    } catch (e) {
      showSnackBar('505: Error occured, failed to sign up user...');
    }
  }
}
