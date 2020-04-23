import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/storage/LocalStorage.dart';

class TaskListsModel extends ChangeNotifier {
  LocalStorage _db;
  List<TaskListModel> _taskLists;

  TaskListsModel();

  init(LocalStorage db) async {
    this._db = db;
    this._taskLists = await _db.taskLists();
  }

  UnmodifiableListView<TaskListModel> get items =>
      UnmodifiableListView(_taskLists);

  add(TaskListModel taskList) async {
    _taskLists.add(taskList);
    await this._db.insertTaskList(taskList);
    notifyListeners();
  }

  update(TaskListModel taskList) async {
    int index = _taskLists.indexWhere((t) => taskList.id == t.id);
    _taskLists.removeAt(index);
    _taskLists.insert(index, taskList);
    await this._db.updateTaskList(taskList);
    notifyListeners();
  }

  remove(TaskListModel taskList) async {
    _taskLists.removeWhere((t) => t.id == taskList.id);
    await this._db.deleteTaskList(taskList);
    notifyListeners();
  }

  Map<String, dynamic> toMap() => {
        "taskLists":
            jsonEncode(_taskLists.map((taskList) => taskList.toMap()).toList())
      };
}
