import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager groceryManager;

  const GroceryListScreen({super.key, required this.groceryManager});

  @override
  Widget build(BuildContext context) {
    // Get the list of grocery items from the manager.
    final groceryItems = groceryManager.groceryItems;
    // Apply padding of 16 pixels all around this screen.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Add ListView.
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final groceryItem = groceryItems[index];
          // TODO: Wrap in a Dismissable
          // We wrap GroceryTile inside an InkWell.
          return Dismissible(
            // The dismissible widget includes a Key. Flutter needs this to find and remove the
            // right element in the tree.
            key: Key(groceryItem.id),
            // Sets the direction the user can swipe to dismiss.
            direction: DismissDirection.endToStart,
            // Selects the background widget to display behind the widget you’re swiping. In
            // this case, the background widget is red with a white trash can Icon aligned in the
            // center and to the right of the Container.
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            // onDismissed lets you know when the user swiped away a GroceryTile.
            onDismissed: (direction) {
              // Lets the grocery manager handle deleting the item, given an index.
              groceryManager.deleteItem(index);
              // Shows a snack bar widget to let the user know which item they deleted.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${groceryItem.name} dismissed!'),
                ),
              );
            },
            child: InkWell(
              // For each item in the list, get the current item and construct a GroceryTile.
              child: GroceryTile(
                key: Key(groceryItem.id),
                groceryItem: groceryItem,
                // Return 'onComplete' when the user taps the checkbox.
                onComplete: (change) {
                  // Check if there is a change and update the item’s 'isComplete' status.
                  if (change != null) {
                    groceryManager.completeItem(index, change);
                  }
                },
              ),
              // When the gesture recognizes a tap, it presents GroceryItemScreen, letting the
              // user edit the current item.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalGroceryItem: groceryItem,
                      // GroceryItemScreen calls onUpdate when the user updates an item.
                      onUpdate: (groceryItem) {
                        // GroceryManager updates the item at the particular index.
                        groceryManager.updateItem(groceryItem, index);
                        // Dismisses GroceryItemScreen.
                        Navigator.pop(context);
                      },
                      // onCreate will not be called since you are updating an existing item.
                      onCreate: (groceryItem) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
        // Space each grocery item 16 pixels apart.
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        // Set the number of items in the list.
        itemCount: groceryItems.length,
      ),
    );
  }
}
