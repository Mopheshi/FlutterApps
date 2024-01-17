import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'screens.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.currentTab,
  });

  final int currentTab;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          profileButton(widget.currentTab),
        ],
      ),
      body: IndexedStack(index: widget.currentTab, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: widget.currentTab,
        onTap: (index) {
          // Updates the current tab the user selected.
          Provider.of<AppStateManager>(context, listen: false).goToTab(index);
          // Uses GoRouter to navigate to the selected tab.
          /// Note: There are two ways to navigate to different routes:
          /// 1.) context.go(path)
          /// 2.) context.goNamed(name)
          /// You should use goNamed instead of go as it’s error-prone, and the actual URI
          /// format can change over time.
          /// goNamed performs a case-insensitive lookup by using the name parameter you
          /// set with each GoRoute. goNamed also helps you pass in parameters and query
          /// parameters to your route.
          context.goNamed('home', params: {'tab': '$index'});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To Buy',
          ),
        ],
      ),
    );
  }

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/atachiz.jpg',
          ),
        ),
        onTap: () {
          // Navigate to Profile Screen
          context.goNamed('profile', params: {'tab': '$currentTab'});
        },
      ),
    );
  }
}
