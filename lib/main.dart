import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  // Everything in Flutter starts with a widget. runApp() takes in the root widget Fooderlich.
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  // Every stateless widget must override the build() method.
  const Fooderlich({super.key});

  @override
  Widget build(BuildContext context) {
    // Create theme
    final theme = FooderlichTheme.dark();
    // Apply Home widget
    // The Fooderlich widget starts by composing a MaterialApp widget to give it a
    // Material Design system look and feel. See https://material.io for more details
    // about it.
    return MaterialApp(
      // Add theme
      theme: theme,
      title: 'Fooderlich',
      // The MaterialApp widget contains a Scaffold widget, which defines the layout
      // and structure of the app. The scaffold has two properties: an appBar and a body.
      // An Appbar’s title contains a Text widget. The body has a Center widget,
      // whose child property is a Text widget.
      home: const Home(),
    );
  }
}
