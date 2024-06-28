import 'dart:math';

import 'package:flutter/material.dart';
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

  Future<List<TaskModel>> getTasksForToday() async {
    final today = DateTime.now();

    if (state.isEmpty) return state;

    return state.where((task) {
      return DateUtils.isSameDay(task.date, today);
    }).toList();
  }

  Future<List<TaskModel>> getTasksForTomorrow() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    if (state.isEmpty) return state;

    return state.where((task) {
      return DateUtils.isSameDay(task.date, tomorrow);
    }).toList();
  }

  Future<List<TaskModel>> getTasksForDayAfterTomorrow() async {
    final dayAfterTomorrow = DateTime.now().add(const Duration(days: 2));

    if (state.isEmpty) return state;

    return state.where((task) {
      return DateUtils.isSameDay(task.date, dayAfterTomorrow);
    }).toList();
  }

  Future<List<TaskModel>> getTaskFromOneMonthAgo() async {
    final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));

    if (state.isEmpty) return state;

    return state.where((task) {
      // Get every task from one month ago excluding today's task
      return task.date!.isAfter(oneMonthAgo) &&
          task.date!.isBefore(DateUtils.dateOnly(DateTime.now()));
    }).toList();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<List<TaskModel>> getCompletedTasksForToday() async {
    if (state.isEmpty) return state;
    final taskForToday = await getTasksForToday();
    return taskForToday.where((task) => task.isCompleted).toList();
  }

  Future<List<TaskModel>> getActiveTasksForToday() async {
    if (state.isEmpty) return state;
    final taskForToday = await getTasksForToday();
    return taskForToday.where((task) => !task.isCompleted).toList();
  }
}
