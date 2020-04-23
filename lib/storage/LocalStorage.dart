import 'dart:convert';

import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/models/TaskModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  Future<Database> database;

  initDatabase() async {
    this.database =
        openDatabase(join(await getDatabasesPath(), 'task_lists.db'),
            onCreate: (db, version) async {
      return await db.execute(
        "CREATE TABLE task_lists(id TEXT PRIMARY KEY, title TEXT, description TEXT, tasks TEXT)",
      );
    }, version: 1);
  }

  Future<void> insertTaskList(TaskListModel taskList) async {
    final Database db = await database;
    await db.insert(
      'task_lists',
      taskList.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskListModel>> taskLists() async {
    final Database db = await database;

    final List<Map<String, dynamic>> taskLists = await db.query('task_lists');

    return List.generate(taskLists.length, (i) {
      List<dynamic> tasks = jsonDecode(taskLists[i]['tasks']);
      return TaskListModel.fromDatabase(
          taskLists[i]['id'],
          taskLists[i]['title'],
          taskLists[i]['description'],
          List.generate(tasks.length, (i) => TaskModel.fromMap(tasks[i])));
    });
  }

  Future<void> updateTaskList(TaskListModel taskList) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'task_lists',
      taskList.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [taskList.id],
    );
  }

  Future<void> deleteTaskList(TaskListModel taskList) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'task_lists',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [taskList.id],
    );
  }
}
