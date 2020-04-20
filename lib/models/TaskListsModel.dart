import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';

class TaskListsModel extends ChangeNotifier {
  List<TaskListModel> _taskLists;

  TaskListsModel(this._taskLists);

  UnmodifiableListView<TaskListModel> get items =>
      UnmodifiableListView(_taskLists);

  add(TaskListModel taskList) {
    _taskLists.add(taskList);
    notifyListeners();
  }

  update(TaskListModel taskList) {
    int index = _taskLists.indexWhere((t) => taskList.id == t.id);
    _taskLists.removeAt(index);
    _taskLists.insert(index, taskList);
    notifyListeners();
  }

  remove(TaskListModel taskList) {
    _taskLists.removeWhere((t) => t.id == taskList.id);
    notifyListeners();
  }

  Map<String, dynamic> toMap() =>
      {"taskLists": _taskLists.map((taskList) => taskList.toMap())};
}
