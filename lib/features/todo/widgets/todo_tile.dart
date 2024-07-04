import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/fading_text.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/extensions/date_extentions.dart';
import 'package:todo_app/core/res/colours.dart';

import '../models/task_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
    this.task, {
    super.key,
    this.onEdit,
    this.onDelete,
    this.bottomMargin,
    required this.endIcon,
    this.colour,
  });

  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double? bottomMargin;
  final Widget endIcon;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colours.lightGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      color: colour ?? Colours.randomColour(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const WhiteSpace(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadingText(
                        task.title!,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const WhiteSpace(height: 3),
                      FadingText(
                        task.description!,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const WhiteSpace(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colours.darkBackground,
                              border: Border.all(
                                width: 0.3,
                                color: Colours.darkGrey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${task.startTime!.timeOnly} | '
                                '${task.endTime!.timeOnly}',
                                style: GoogleFonts.poppins(
                                  color: Colours.light,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const WhiteSpace(width: 20),
                          IconButton(
                              onPressed: onEdit,
                              icon: const Icon(
                                MaterialCommunityIcons.circle_edit_outline,
                                color: Colours.light,
                              )),
                          const WhiteSpace(width: 20),
                          IconButton(
                            onPressed: onDelete,
                            icon: const Icon(
                                MaterialCommunityIcons.delete_circle),
                            color: Colours.light,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              endIcon,
            ],
          ),
        ),
      ],
    );
  }
}
