import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/widgets/white_space.dart';
import '../../../core/res/colours.dart';

class TaskExpansionTile extends StatefulWidget {
  const TaskExpansionTile({
    required this.title,
    required this.subtitle,
    required this.chilren,
    this.colour,
    super.key,
  });

  final String title, subtitle;
  final List<Widget> chilren;
  final Color? colour;

  @override
  State<TaskExpansionTile> createState() => _TaskExpansionTileState();
}

class _TaskExpansionTileState extends State<TaskExpansionTile> {
  final controller = ExpansionTileController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colours.lightBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (_) => setState(() {}),
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 80.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: widget.colour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const WhiteSpace(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colours.light,
                      ),
                    ),
                    const WhiteSpace(height: 5),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          controller: controller,
          trailing: Builder(builder: (secondContext) {
            final innerController = ExpansionTileController.of(secondContext);
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: innerController.isExpanded
                  ? const Icon(AntDesign.closecircle)
                  : const Icon(AntDesign.circledown, color: Colors.white54),
            );
          }),
          children: widget.chilren,
        ),
      ),
    );
  }
}
