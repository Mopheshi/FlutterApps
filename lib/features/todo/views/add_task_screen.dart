import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/common/widgets/filled_field.dart';
import 'package:todo_app/core/common/widgets/round_button.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/todo/app/task_date_provider.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';

import '../models/task_model.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleContoller = useTextEditingController(),
        descriptionContoller = useTextEditingController();

    final dateNotifier = ref.read(taskDateProvider.notifier),
        startTimeNotifier = ref.read(taskStartTimeProvider.notifier),
        endTimeNotifier = ref.read(taskEndTimeProvider.notifier);

    final dateProvider = ref.watch(taskDateProvider),
        startTimeProvider = ref.watch(taskStartTimeProvider),
        endTimeProvider = ref.watch(taskEndTimeProvider);

    final hintStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colours.lightGrey,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colours.light,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            const WhiteSpace(height: 20),
            FilledField(
              controller: titleContoller,
              hintText: "Add Title",
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20),
            FilledField(
              controller: descriptionContoller,
              hintText: "Add Description",
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20),
            RoundButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime.now(),
                  maxTime: DateTime(DateTime.now().year + 1),
                  theme: DatePickerTheme(
                    doneStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colours.green,
                    ),
                  ),
                  onConfirm: (date) {
                    dateNotifier.changeDate(date);
                  },
                );
              },
              text: dateProvider == null ? "Set Date" : dateNotifier.date()!,
              backgroundColour: Colours.lightGrey,
              borderColour: Colours.light,
            ),
            const WhiteSpace(height: 20),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: "Please select a date first...",
                        );
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        theme: DatePickerTheme(
                          doneStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colours.green,
                          ),
                        ),
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          startTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: startTimeProvider == null
                        ? "Start Time"
                        : startTimeNotifier.time()!,
                    backgroundColour: Colours.lightGrey,
                    borderColour: Colours.light,
                  ),
                ),
                const WhiteSpace(width: 20),
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: "Please select a Start Time first...",
                        );
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        theme: DatePickerTheme(
                          doneStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colours.green,
                          ),
                        ),
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          endTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: endTimeProvider == null
                        ? "End Time"
                        : endTimeNotifier.time()!,
                    backgroundColour: Colours.darkGrey,
                    borderColour: Colours.light,
                  ),
                ),
              ],
            ),
            const WhiteSpace(height: 20),
            RoundButton(
              onPressed: () async {
                final title = titleContoller.text.trim(),
                    description = descriptionContoller.text.trim(),
                    date = dateProvider,
                    startTime = startTimeProvider,
                    endTime = endTimeProvider;
                final navigator = Navigator.of(context);

                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    date != null &&
                    startTime != null &&
                    endTime != null) {
                  CoreUtils.showLoader(context);

                  await ref.read(taskProvider.notifier).addTask(TaskModel(
                        title: title,
                        description: description,
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                      ));

                  navigator
                    ..pop()
                    ..pop();
                } else {
                  CoreUtils.showSnackBar(
                    context: context,
                    message: "Please fill all fields...",
                  );
                }
              },
              text: "Submit",
              backgroundColour: Colours.green,
              borderColour: Colours.light,
            ),
          ],
        ),
      ),
    );
  }
}
