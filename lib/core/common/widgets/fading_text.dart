import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colours.dart';

class FadingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final color;
  final TextAlign? textAlign;

  const FadingText(
    this.text, {
    super.key,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.fade,
      textAlign: textAlign ?? TextAlign.left,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colours.light,
      ),
    );
  }
}
