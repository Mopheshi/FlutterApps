import 'package:flutter/material.dart';

import 'circular_image.dart';
import 'fooderlich_theme.dart';

class AuthorCard extends StatefulWidget {
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

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavourited = false;

  // AuthorCard is grouped in a container and uses a Row widget to lay out the other elements
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
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              // Applies 8 pixels of padding between the image and the text.
              const SizedBox(width: 8),
              // Lays out the author’s name and job title vertically using a Column.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorsName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                ],
              )
            ],
          ),
          // Add IconButton
          IconButton(
            // When the user presses the IconButton, it toggles the '_isFavorited' state via a call to setState().
            onPressed: () {
              setState(() {
                _isFavourited = !_isFavourited;
              });
              // Shoq a SnackBar when IconButton is pressed
              // const snackBar =
              //     SnackBar(content: Text('Added recipe to favourites...'));
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            // First, it checks if the user has favorited this recipe card. If true, it shows a filled
            // heart. If false, it shows an outlined heart.
            icon: Icon(_isFavourited ? Icons.favorite : Icons.favorite_border),
            iconSize: 30,
            // It changes the color to red to give the app more life.
            color: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
