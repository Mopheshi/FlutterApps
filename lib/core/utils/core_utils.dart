import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreUtils {
  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showLoader(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null)
            Text(
              '$message...',
              style: GoogleFonts.poppins(
                color: Colors.lightBlueAccent,
              ),
            ),
        ],
      ),
    );
  }
}
