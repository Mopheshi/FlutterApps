import 'package:flutter/material.dart';

import 'Card0.dart';
import 'Card1.dart';
import 'Card2.dart';

// Class extends StatefulWidget.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // _selectedIndex keeps track of which tab is currently selected. The underscore
  // in _selectedIndex signifies it’s private. The selected index is the state being
  // tracked by _HomeState.
  int _selectedIndex = 0;

  // Here, we define the card widgets that will display on each tab
  static List<Widget> pages = <Widget>[
    const Card0(),
    const Card1(),
    const Card2(),
  ];

  // This function handles tapped tab bar items. Here, we set the index of the item
  // that the user pressed. setState() notifies the framework that the state of this
  // object has changed, then rebuilds this widget internally.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            // The AppBar style now reads: Theme.of(context).textTheme.headline6
            // instead of: theme.textTheme.headline6. Theme.of(context) returns the
            // nearest Theme in the widget tree. If the widget has a defined Theme, it returns
            // that. Otherwise, it returns the app’s theme.
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        // Show selected tab
        body: pages[_selectedIndex],
        // Define a BottomNavigationBar.
        bottomNavigationBar: BottomNavigationBar(
          // Set the selection color of an item when tapped.
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          // Set selected tab bar
          // currentIndex will tell the bottom navigation bar which tab bar item to highlight.
          currentIndex: _selectedIndex,
          // When the user taps on a tab bar item, it calls the _onItemTapped handler, which
          // updates the state with the correct index. In this case, it changes the color.
          onTap: _onItemTapped,
          // Defined three bottom navigation tab bar items.
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Card0',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Card1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Card2',
            ),
          ],
        ));
  }
}
