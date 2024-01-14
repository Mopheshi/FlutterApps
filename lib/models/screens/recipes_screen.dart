import 'package:flutter/material.dart';

import '../../api/mock_fooderlich_service.dart';
import '../../components/components.dart';
import '../simple_recipe.dart';

class RecipesScreen extends StatelessWidget {
  // Create a mock service.
  final exploreService = MockFooderlichService();

  RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a FutureBuilder.
    return FutureBuilder(
      // Use getRecipes() to return the list of recipes to display. This function returns a
      // future list of SimpleRecipes.
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapShot) {
        // Check if the future is complete.
        if (snapShot.connectionState == ConnectionState.done) {
          // Add RecipesGridView. When the list of recipes has been loaded this will display them in a grid layout.
          return RecipesGridView(recipes: snapShot.data ?? []);
        } else {
          // Show a circular loading indicator if the future isn’t complete yet.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
