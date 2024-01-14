import 'dart:developer';

import 'package:flutter/material.dart';

import '../../api/mock_fooderlich_service.dart';
import '../../components/components.dart';
import '../explore_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Create a MockFooderlichService, to mock server responses.
  final mockService = MockFooderlichService();
  late ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    // This is the FutureBuilder from before. It runs an asynchronous task and lets
    // you know the state of the future.
    return FutureBuilder(
      // Use your mock service to call getExploreData(). This returns an ExploreData
      // object future.
      future: mockService.getExploreData(),
      // Check the state of the future within the builder callback.
      builder: (context, AsyncSnapshot<ExploreData> snapShot) {
        // Check if the future is complete.
        if (snapShot.connectionState == ConnectionState.done) {
          // When the future is complete, return the primary ListView. This holds an explicit
          // list of children. In this scenario, the primary ListView will hold the other two
          // ListViews as children.
          return ListView(
            // ScrollController, listens to scrolls and responds accordingly.
            controller: _controller,
            // Set the scroll direction to vertical, although that’s the default value.
            scrollDirection: Axis.vertical,
            children: [
              // The first item in children is TodayRecipeListView. You pass in the list of
              // todayRecipes from ExploreData.
              TodayRecipeListView(recipes: snapShot.data?.todayRecipes ?? []),
              // Add a 16-point vertical space so the lists aren’t too close to each other.
              const SizedBox(height: 16),
              // Add FriendPostListView
              FriendPostListView(friendPosts: snapShot.data?.friendPosts ?? []),
            ],
          );
        } else {
          //
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // You initialize the scroll controller.
    _controller = ScrollController();
    // You add a listener to the controller. Every time the user scrolls, scrollListner() gets called.
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
  }

  void _scrollListener() {
    // Check the scroll offset to see if the position is greater than or equal
    // to the maxScrollExtent. If so, the user has scrolled to the very bottom.
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      log('I am at the very bottom!');
    }
    // Check if the scroll offset is less than or equal to minScrollExtent. If so, the user
    // has scrolled to the very top.
    if (_controller.offset <= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      log('I am at the very top!');
    }
  }
}
