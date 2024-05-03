import 'dart:async';

import 'package:path/path.dart';
import 'package:proyecto_final_dam/config/models/tasks/task_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get a location using getDatabasesPath
    String path = join(await getDatabasesPath(), 'tasks_database.db');

    // Open/create the database at a given path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
          CREATE TABLE tasks (
            _id TEXT PRIMARY KEY,
            taskName TEXT,
            taskDescription TEXT,
            status INTEGER,
            userId TEXT,
            creationDate TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert(
      'tasks',
      task.allTaskDataToJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['_id'],
        taskName: maps[i]['taskName'],
        taskDescription: maps[i]['taskDescription'],
        status: maps[i]['status'] == 1,
        userId: maps[i]['userId'],
        creationDate: maps[i]['creationDate'] != null
            ? DateTime.parse(maps[i]['creationDate'])
            : null,
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.allTaskDataToJson(),
      where: '_id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllTasks() async {
    final db = await database;
    await db.delete('tasks');
  }

  Future<void> updateLocalDatabase(List<Task> tasks) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('tasks');
        for (Task task in tasks) {
          await txn.insert('tasks', task.allTaskDataToJson());
        }
      });
    } catch (e) {
      print("Update Local Database Error: $e");
      throw e;
    }
  }
}
