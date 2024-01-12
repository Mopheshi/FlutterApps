import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteSpce extends StatelessWidget {
  final double? width, height;

  const WhiteSpce({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Add .w and .h for size adaptation in smaller/larger screens
      width: width?.w,
      height: height?.h,
    );
  }
}
