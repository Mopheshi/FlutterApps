import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../models/task_model.dart';
import '../views/add_or_edit_task_screen.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder<List<TaskModel>>(
      future: TodoUtils.getActiveTasksForToday(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Yay! No pending tasks for today...',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colours.light,
                ),
              ),
            );
          } else {
            return ColoredBox(
              color: Colours.lightBackground,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final task = snapshot.data![index];
                  final isLast = index == snapshot.data!.length - 1;
                  return TodoTile(
                    task,
                    bottomMargin: isLast ? null : 10,
                    onDelete: () {
                      ref.read(taskProvider.notifier).deleteTask(task.id!);
                    },
                    onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddOrEditTaskScreen(task: task),
                      ),
                    );
                  },
                    endIcon: Switch(
                      value: task.isCompleted,
                      onChanged: (value) {
                        task.isCompleted = true;
                        ref.read(taskProvider.notifier).markAsCompleted(task);
                      },
                      // activeColor: Colours.primary,
                    ),
                  );
                },
              ),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
