import 'package:flutter/cupertino.dart';
import 'package:todo_app/features/authentication/repository/authentication_repository.dart';

class AuthenticationController {
  final AuthenticationRepository repository;

  const AuthenticationController(this.repository);

  Future<void> sentOTP(
          {required BuildContext context, required String phoneNumber}) async =>
      repository.sendOTP(
        context: context,
        phoneNumber: phoneNumber,
      );
}
