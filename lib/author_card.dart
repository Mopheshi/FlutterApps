import 'package:flutter/material.dart';

import 'circular_image.dart';
import 'fooderlich_theme.dart';

class AuthorCard extends StatelessWidget {
  // AuthorCard has three properties: authorName, the author’s job title and the
  // profile image, which imageProvider handles.
  final String authorsName, title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    super.key,
    required this.authorsName,
    required this.title,
    this.imageProvider,
  });

  // AuthorCard is grouped in a container and uses a Row widget to lay out the other
  // widgets horizontally.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        // Add alignment
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The inner Row groups the CircleImage and the author’s Text information.
          Row(
            children: [
              CircularImage(
                imageProvider: imageProvider,
                imageRadius: 28,
              ),
              // Applies 8 pixels of padding between the image and the text.
              const SizedBox(width: 8),
              // Lays out the author’s name and job title vertically using a Column.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorsName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                ],
              )
            ],
          ),
          // Add IconButton
          IconButton(
            // When the user presses the icon, display a snackbar.
            onPressed: () {
              const snackBar =
                  SnackBar(content: Text('Added recipe to favourites...'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            // Set the icon, size and color of the icon.
            icon: const Icon(Icons.favorite_border),
            iconSize: 30,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
