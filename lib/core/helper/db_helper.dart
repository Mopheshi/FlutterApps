import 'package:sqflite/sqflite.dart';

/// A helper class for the database
class DBHelper {
  /// Private constructor
  const DBHelper._();

  /// Creates the table in the database
  static Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,
        isVerified INTEGER DEFAULT 0
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
}
