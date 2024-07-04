import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/extensions/date_extentions.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';
import 'package:todo_app/features/todo/widgets/task_expansion_tile.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../models/task_model.dart';
import '../views/add_or_edit_task_screen.dart';

class TasksForDayAfterTomorrow extends ConsumerWidget {
  const TasksForDayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder<List<TaskModel>>(
      future: TodoUtils.getTasksForDayAfterTomorrow(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final colour = Colours.randomColour();
          return TaskExpansionTile(
            title: '${snapshot.data!.first.date!.dateOnly} Tasks',
            subtitle: "Excludes today's and tomorrow's tasks...",
            colour: colour,
            chilren: snapshot.data!.map((task) {
              final isLast = snapshot.data!
                      .indexWhere((element) => element.id == task.id) ==
                  snapshot.data!.length - 1;
              return TodoTile(
                task,
                colour: colour,
                bottomMargin: isLast ? null : 10,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrEditTaskScreen(task: task),
                    ),
                  );
                },
                onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task.id!);
                },
                endIcon: Switch(
                  value: task.isCompleted,
                  onChanged: (_) async {
                    task.isCompleted = true;
                    await ref.read(taskProvider.notifier).markAsCompleted(task);
                    // NotificationService.cancelNotification(task.id!);
                  },
                ),
              );
            }).toList(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
