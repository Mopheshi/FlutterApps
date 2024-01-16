import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class GroceryTile extends StatelessWidget {
  // You include a GroceryItem to configure the tile.
  final GroceryItem groceryItem;

  // onComplete is a callback handler that lets you know whether the user toggled the
  // checkbox on or off.
  Function(bool?)? onComplete;

  // textDecoration helps style all the Texts.
  final TextDecoration textDecoration;

  // When you initialize a GroceryTile, you check the item to see if the user marked
  // it as complete. If so, you show a strike through the text. Otherwise, you display
  // the text as normal.
  GroceryTile({
    super.key,
    required this.groceryItem,
    this.onComplete,
  }) : textDecoration = groceryItem.isComplete
            ? TextDecoration.lineThrough
            : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Add a Row to lay out elements in the horizontal direction.
          Row(
            children: [
              // Add a container widget with the item’s color. This helps to color-code items.
              Container(width: 0.5, color: groceryItem.color),
              // Space the elements 16 pixels apart.
              const SizedBox(width: 16.0),
              // Add a Column to lay out elements in the vertical direction.
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lay out elements spaced 4 pixels apart in the following order: item name, date and importance.
                  Text(
                    groceryItem.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(),
                  const SizedBox(height: 4.0),
                  buildImportance(),
                ],
              ),
            ],
          ),
          // Add a Row to lay out elements in the horizontal direction.
          Row(
            children: [
              // Add a Text to display the item’s quantity.
              Text(
                groceryItem.quantity.toString(),
                style: GoogleFonts.lato(
                  fontSize: 21.0,
                  decoration: textDecoration,
                ),
              ),
              // Add the checkbox.
              buildCheckbox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImportance() {
    if (groceryItem.importance == Importance.low) {
      return Text('Low', style: GoogleFonts.lato(decoration: textDecoration));
    } else if (groceryItem.importance == Importance.medium) {
      return Text('Medium',
          style: GoogleFonts.lato(
              decoration: textDecoration, fontWeight: FontWeight.w800));
    } else if (groceryItem.importance == Importance.high) {
      return Text('High',
          style: GoogleFonts.lato(
              decoration: textDecoration, fontWeight: FontWeight.w900));
    } else {
      throw Exception('The importance type does not exist...');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(groceryItem.date);
    return Text(dateString,
        style: GoogleFonts.lato(decoration: textDecoration));
  }

  Widget buildCheckbox() {
    return Checkbox(
      // Toggles the checkbox on or off based on item.isComplete.
      value: groceryItem.isComplete,
      // Triggers the onComplete callback when the user taps the checkbox.
      onChanged: onComplete,
    );
  }
}
