import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/grocery_manager.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The main layout structure for GroceryScreen is a scaffold.
    return Scaffold(
      // Adds a floating action button with a + icon. Tapping the button presents the
      // GroceryItemScreen to create or add an item.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Returns the GroceryManager available in the tree.
          final manager = Provider.of<GroceryManager>(context, listen: false);
          // Navigator.push() adds a new route to the stack of routes.
          Navigator.push(
            context,
            // MaterialPageRoute replaces the entire screen with a platform-specific
            // transition. In Android, for example, it slides upwards and fades in. In iOS, it slides
            // in from the right.
            MaterialPageRoute(
              // Creates a new GroceryItemScreen within the route’s builder callback.
              builder: (context) => GroceryItemScreen(
                // onCreate defines what to do with the created item.
                onCreate: (groceryItem) {
                  // addItem() adds this new grocery item to the list of items.
                  manager.addItem(groceryItem);
                  // Once the item is added to the list, pop() removes the top navigation route item,
                  // GroceryItemScreen, to show the list of grocery items.
                  Navigator.pop(context);
                },
                // onUpdate will never get called since you are creating a new item.
                onUpdate: (groceryItem) {},
              ),
            ),
          );
        },
      ),
      // Builds the rest of the Grocery screen’s subtree.
      body: buildGroceryScreen(),
    );
  }

  /// Tip: You should only wrap a Consumer around widgets that need it. For
  /// example, wrapping a consumer widget at the top level would force it to rebuild
  /// the entire tree!
  Widget buildGroceryScreen() {
    // You wrap your widgets inside a Consumer, which listens for GroceryManager state changes.
    return Consumer<GroceryManager>(
      // Consumer rebuilds the widgets below itself when the grocery manager items changes.
      builder: (context, manager, child) {
        // If there are grocery items in the list, show the GroceryListScreen.
        if (manager.groceryItems.isNotEmpty) {
          // TODO: Add GroceryListScreen
          return Container();
        } else {
          // If there are no grocery items, show the EmptyGroceryScreen.
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
