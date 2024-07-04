import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../models/task_model.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder<List<TaskModel>>(
      future: TodoUtils.getCompletedTasksForToday(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'Hmmm... No completed tasks for today!',
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
                      task: task,
                      bottomMargin: isLast ? null : 10,
                      onDelete: () {
                        ref.read(taskProvider.notifier).deleteTask(task.id!);
                      },
                      endIcon: const Icon(
                        AntDesign.checkcircle,
                        color: Colours.green,
                      ));
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
