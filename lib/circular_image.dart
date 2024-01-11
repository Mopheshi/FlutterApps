import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  // The imageRadius and imageProvider property declarations.
  final double imageRadius;

  // Identifies an image without committing to the precise final asset. This allows a set of images to be identified and for the precise image to later be resolved based on the environment, e.g. the device pixel ratio.
  final ImageProvider? imageProvider;

  // CircleImage has two parameters: imageProvider and imageRadius.
  const CircularImage({
    super.key,
    this.imageProvider,
    this.imageRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    // CircleAvatar is a widget provided by the Material library. It’s defined as a white
    // circle with a radius of imageRadius.
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: imageRadius,
      // Within the outer circle is another CircleAvatar, which is a smaller circle that
      // includes the user’s profile image. Making the inner circle smaller gives you the
      // white border effect.
      child: CircleAvatar(
        radius: imageRadius - 2,
        backgroundImage: imageProvider,
      ),
    );
  }
}
