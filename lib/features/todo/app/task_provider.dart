import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/core/helper/db_helper.dart';

import '../models/task_model.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();

    // final tasks = [];
    // for (final task in data) {
    //   tasks.add(TaskModel.fromMap(task));
    // }
    // state = tasks;

    /// Get the data from the database and convert it to a list of TaskModel

    // The above code can be simplified to:
    state = data.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<void> deleteTask(int id) async {
    await DBHelper.deleteTask(id);
    refresh();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }
}
