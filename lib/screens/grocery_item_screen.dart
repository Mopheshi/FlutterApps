import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    // When the originalItem is not null, the user is editing an existing item. In this
    // case, you must configure the widget to show the item’s values.
    final orginalGroceryItem = widget.originalGroceryItem;
    if (orginalGroceryItem != null) {
      _name = orginalGroceryItem.name;
      _currentSliderValue = orginalGroceryItem.quantity;
      _importance = orginalGroceryItem.importance;
      _currentColor = orginalGroceryItem.color;
      final date = orginalGroceryItem.dateTime;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDateTime = date;
    }

    // Adds a listener to listen for text field changes. When the text changes, you set the _name.
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  // This will dispose your TextEditingController when you no longer need it.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold defines the main layout and structure of the entire screen.
    return Scaffold(
      // Includes an app bar with one action button. The user will tap this button when
      // they’ve finished creating an item.
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Add a callback handler
            },
            icon: const Icon(Icons.check),
          ),
        ],
        // Sets elevation to 0.0, removing the shadow under the app bar.
        elevation: 0.0,
        // Sets the title of the app bar.
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      // Shows a ListView, padded by 16 pixels on every side, within the body of the scaffold.
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            buildNameField(),
            // TODO: Add Importance selection
            // TODO: Add date picker
            // TODO: Add time picker
            // TODO: Add color picker
            // TODO: Add slider
            // TODO: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    // Creates a Column to lay elements out vertically.
    return Column(
      // Aligns all widgets in the column to the left.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Adds a Text that’s styled using GoogleFonts.
        Text(
          'Grocery Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // Adds a TextField to enter the name of the item.
        TextField(
          // Sets the TextField’s TextEditingController.
          controller: _nameController,
          // Sets the cursor color.
          cursorColor: _currentColor,
          // Styles the text field using InputDecoration.
          decoration: const InputDecoration(
            // Includes a hint to give users an example of what to write.
            hintText: 'E.g. Apples, Banana, 1 Bag of salt...',
            // Customizes the text field’s border color.
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

// TODO: Add buildImportanceField()
// TODO: ADD buildDateField()
// TODO: Add buildTimeField()
// TODO: Add buildColorPicker()
// TODO: Add buildQuantityField()
}
