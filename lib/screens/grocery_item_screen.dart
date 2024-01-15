import 'package:flutter/material.dart';

import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  // onCreate is a callback that lets you know when a new item is created.
  final Function(GroceryItem) onCreate;

  // onUpdate is a callback that returns the updated grocery item.
  final Function(GroceryItem) onUpdate;

  // The grocery item that the user clicked.
  final GroceryItem? originalGroceryItem;

  // isUpdating determines whether the user is creating or editing an item.
  final bool isUpdating;

  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalGroceryItem,
  }) : isUpdating = (originalGroceryItem != null);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // TODO: Add grocery item screen state properties

  @override
  Widget build(BuildContext context) {
    // TODO: Add GroceryItemScreen Scaffold
    return Container(
      color: Colors.orange,
    );
  }

// TODO: Add buildNameField()
// TODO: Add buildImportanceField()
// TODO: ADD buildDateField()
// TODO: Add buildTimeField()
// TODO: Add buildColorPicker()
// TODO: Add buildQuantityField()
}
