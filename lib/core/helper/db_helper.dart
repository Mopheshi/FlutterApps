import 'package:sqflite/sqflite.dart';

import '../../features/todo/models/task_model.dart';

/// A helper class for the database
class DBHelper {
  /// Private constructor
  const DBHelper._();

  /// Creates the table in the database
  static Future<void> createTable(Database database) async {
    // Create the users table
    await database.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,
        isVerified INTEGER DEFAULT 0
      )
    ''');

    // Create the tasks table
    await database.execute('''
      CREATE TABLE IF NOT EXISTS tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,
        title STRING,
        description TEXT,
        date STRING,
        startTime STRING,
        endTime STRING,
        reminder INTEGER DEFAULT 0,
        repeat STRING,
        isCompleted INTEGER DEFAULT 0
      )
    ''');
  }

  /// Opens the database
  static Future<Database> db() async {
    return openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  /// Creates a user in the database
  static Future<void> createUser({required bool isVerified}) async {
    final localDB = await db();

    final data = {
      'id': 1,
      'isVerified': isVerified ? 1 : 0,
    };

    await localDB.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Checks if a user exists in the database
  static Future<bool> userExists() async {
    final localDB = await db();
    final result = await localDB.query('users');
    return result.isNotEmpty;
  }

  /// Deletes every row in the users table/Drops the users table from the database
  static Future<void> deleteUser() async {
    final localDB = await db();
    await localDB.delete('users');
  }

  /// Adds a task to the database
  static Future<void> addTask(TaskModel task) async {
    final localDB = await db();

    await localDB.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Updates a task in the database
  static Future<void> updateTask(int taskId, {required TaskModel task}) async {
    final localDB = await db();

    await localDB.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Deletes a task from the database
  static Future<void> deleteTask(int taskId) async {
    final localDB = await db();
    await localDB.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  /// Gets all tasks from the task table in the database
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final localDB = await db();
    return await localDB.query('tasks', orderBy: 'id');
  }

  /// Get a task from the task table in the database
  static Future<Map<String, dynamic>> getTaskById(int taskId) async {
    final localDB = await db();
    final task = await localDB.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
      limit: 1,
    );

    if (task.isEmpty) return {};
    return task.first;
  }
}
