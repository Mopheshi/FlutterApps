import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/memory_repository.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    // This adds a Consumer widget to display the current ingredients.
    return Consumer<MemoryRepository>(
      builder: (context, repository, child) {
        final ingredients = repository.findAllIngredients();
        return ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value:
                  checkBoxValues.containsKey(index) && checkBoxValues[index]!,
              // This will display the ingredient’s name property.
              title: Text(ingredients[index].name ?? ''),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    checkBoxValues[index] = newValue;
                  });
                }
              },
            );
          },
        );
      },
    );
  }
}
