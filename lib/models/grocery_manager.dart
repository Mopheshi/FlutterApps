import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  // This manager holds a private array of _groceryItems. Only the manager can
  // change and update grocery items.
  final _groceryItems = <GroceryItem>[];

  // Provides a public getter method for groceryItems, which is unmodifiable.
  // External entities can only read the list of grocery items.
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // deleteItem() deletes a  grocery item at a particular index.
  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // addItem() adds a new grocery item at the end of the list.
  void addItem(GroceryItem groceryItem) {
    _groceryItems.add(groceryItem);
    notifyListeners();
  }

  // updateItem() replaces the old item at a given index with a new item.
  void updateItem(GroceryItem groceryItem, int index) {
    _groceryItems[index] = groceryItem;
  }

  // completeItem() toggles the isComplete flag on and off.
  void completeItem(int index, bool change) {
    final groceryItem = _groceryItems[index];
    _groceryItems[index] = groceryItem.copyWith(isComplete: change);
    notifyListeners();
  }
}
