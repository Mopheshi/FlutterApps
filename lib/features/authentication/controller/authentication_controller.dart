import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/authentication/repository/authentication_repository.dart';

final authControllerProvider = Provider((ref) => AuthenticationController(
      ref.watch(authRepoProvider),
    ));

class AuthenticationController {
  final AuthenticationRepository repository;

  const AuthenticationController(this.repository);

  Future<void> sentOTP(
          {required BuildContext context, required String phoneNumber}) async =>
      repository.sendOTP(context: context, phoneNumber: phoneNumber);

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async =>
      repository.verifyOTP(
        context: context,
        verificationId: verificationId,
        otp: otp,
      );
}
