import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../data/memory_repository.dart';
import '../../data/models/models.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({Key? key}) : super(key: key);

  @override
  State createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    return Consumer<MemoryRepository>(
      builder: (context, repository, child) {
        // 'findAllRecipes()' will return either all the current recipes or an empty list.
        recipes = repository.findAllRecipes();
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            // itemBuilder receives the current index so that we can retrieve the recipe at that index.
            final recipe = recipes[index];
            return SizedBox(
              height: 100,
              child: Slidable(
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      label: 'Delete',
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      onPressed: (context) {
                        deleteRecipe(repository, recipe);
                      },
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      label: 'Delete',
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      onPressed: (context) {
                        deleteRecipe(repository, recipe);
                      },
                    ),
                  ],
                ),
                child: Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/pizza_w700.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  // Align(
                  // alignment: Alignment.topLeft,
                  // child: CachedNetworkImage(
                  // imageUrl: recipe.image ?? '',
                  // alignment: Alignment.topLeft,
                  // fit: BoxFit.fill,
                  // width: size.width,
                  // ),
                  // ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteRecipe(MemoryRepository repository, Recipe recipe) async {
    // The repository to delete the recipe.
    repository.deleteRecipe(recipe);
    // 'setState()' to redraw the view.
    setState(() {});
  }
}
