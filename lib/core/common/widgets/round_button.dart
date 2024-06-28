import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colours.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColour;
  final Color? borderColour;

  const RoundButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColour,
    this.borderColour,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColour ?? Colours.light,
        minimumSize: Size(screenSize.width * 0.9, screenSize.height * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: borderColour == null
              ? BorderSide.none
              : BorderSide(
                  color: borderColour!,
                ),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: borderColour ?? Colours.darkBackground,
        ),
      ),
    );
  }
}
