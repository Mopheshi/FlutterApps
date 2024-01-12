import 'dart:developer';

import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag2.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            // Add dark overlay BoxDecoration
            Container(
              decoration: BoxDecoration(
                // Add a container with a color overlay with a 60% semi-transparent
                // background to make the image appear darker.
                color: Colors.black.withOpacity(0.5),
                // This gives the appearance of rounded image corners with a radius of 10.0
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            // Add Container, Column, Icon and Text
            Container(
              // Apply padding of 16 pixels on all sides.
              padding: const EdgeInsets.all(16),
              // Set up a child Column to lay out the widgets vertically.
              child: Column(
                // Position all the widgets to the left of the column.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add a book icon.
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 40,
                  ),
                  // Apply an 8-pixel space vertically.
                  const SizedBox(height: 8),
                  // Add the text widget.
                  Text(
                    'Recipe Trends',
                    style: FooderlichTheme.darkTextTheme.headline2,
                  ),
                  // Apply a 30-pixel space vertically.
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Add Center widget with Chip widget children
            // You add a Center widget.
            Center(
              // Wrap is a layout widget that attempts to lay out each of its children adjacent to
              // the previous children. If there’s not enough space, it wraps to the next line.
              child: Wrap(
                // Place the children as close to the left, i.e. the start, as possible.
                alignment: WrapAlignment.start,
                // Apply a 12-pixel space between each child in the main axis.
                spacing: 12,
                // Apply a 12-pixel space between each child in the cross axis.
                runSpacing: 12,
                children: [
                  // Add the list of Chip widgets.
                  Chip(
                    label: Text('Healthy',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      log('Deleted');
                    },
                  ),
                  Chip(
                    label: Text('Vegan',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      log('Deleted');
                    },
                  ),
                  Chip(
                    label: Text('Carrots',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text('Green',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text('Wheat',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text('Pescetarian',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text('Mint',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text('Lemongrass',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
