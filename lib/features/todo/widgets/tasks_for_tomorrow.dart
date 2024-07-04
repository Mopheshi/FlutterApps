import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../models/task_model.dart';

class TasksForTomorrow extends ConsumerWidget {
  const TasksForTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder<List<TaskModel>>(
      future: TodoUtils.getTasksForTomorrow(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return const ExpansionTile(
            title: Text('Hello World!'),
            subtitle: Text('Well'),
          );
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

        return const SizedBox.shrink();
      },
    );
  }
}
