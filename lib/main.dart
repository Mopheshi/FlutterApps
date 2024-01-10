import 'package:flutter/material.dart';

import 'recipe.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Recipe Calculator',
      theme: theme.copyWith(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.grey,
          secondary: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView.builder(
            // Builds a list using ListView.
            itemCount: Recipe.samples.length,
            itemBuilder: (BuildContext context, int index) {
              // itemBuilder builds the widget tree for each row.
              return GestureDetector(
                // Introduces a GestureDetector widget, which, as the name implies, detects gestures.
                onTap: () {
                  // Implements an onTap() function, which is the callback called when the widget is tapped.
                  // The Navigator widget manages a stack of pages. Calling push() with a
                  // MaterialPageRoute will push a new Material page onto the stack. Section III,
                  // “Navigating Between Screens”, will cover navigation in a lot more detail.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // builder creates the destination page widget.
                        // TODO: Replace return with return RecipeDetail()
                        return const Text('Detail Page');
                      },
                    ),
                  );
                },
                // GestureDetector’s child widget defines the area where the gesture is active.
                child: buildRecipeCard(Recipe.samples[
                    index]), // A Text widget displays the name of the recipe.
              );
            }),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
      elevation: 2.0,
      //  A card’s elevation determines how high off the screen the card is, affecting its shadow.

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // shape handles the shape of the card. This code defines a rounded rectangle with a 10.0 corner radius.

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // The padding child is still the same vertical Column with the image and text.

        child: Column(
          children: <Widget>[
            Image(image: AssetImage(recipe.imageUrl)),
            const SizedBox(
              // Between the image and text is a SizedBox. This is a blank view with a fixed size.
              height: 14.0,
            ),
            Text(
              recipe.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            )
          ],
        ),
      ),
    );
  }
}
