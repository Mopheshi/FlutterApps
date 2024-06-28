import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/filled_field.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';

import '../../../core/helper/db_helper.dart';
import '../../../core/res/colours.dart';
import '../../authentication/views/signin_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colours.darkBackground,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        icon: const Icon(
                          AntDesign.logout,
                          color: Colours.light,
                        ),
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    Text(
                      'Task Management',
                      style: GoogleFonts.poppins(
                        color: Colours.light,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddTaskScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colours.darkBackground,
                      ),
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        backgroundColor: Colours.light,
                      ),
                    ),
                  ],
                ),
                const WhiteSpace(height: 20),
                const FilledField(
                  prefixIcon: Icon(AntDesign.search1),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    FontAwesome.sliders,
                    color: Colours.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: Colours.light,
                ),
                const WhiteSpace(width: 10),
                Text(
                  "Today's Tasks",
                  style: GoogleFonts.poppins(
                    color: Colours.light,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const WhiteSpace(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: Colours.light,
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: Colours.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: Colors.lightBlue,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Colours.light,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        child: Center(
                          child: Text("Pending", style: tabTextStyle),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        child: Center(
                          child: Text("Completed", style: tabTextStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(height: 20),
            SizedBox(
              height: screenHeight * 0.26,
              child: TabBarView(
                controller: tabController,
                children: const [
                  ColoredBox(color: Colors.red),
                  ColoredBox(color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
