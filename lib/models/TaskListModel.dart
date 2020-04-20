import 'package:fluttertaskapp/models/TaskModel.dart';
import 'package:uuid/uuid.dart';

class TaskListModel {
  TaskListModel([this._title, this._description, this._tasks]) {
    var uuid = new Uuid();
    this.id = uuid.v4();
  }

  String id;
  String _title;
  String _description;
  List<TaskModel> _tasks;

  String get title => _title;

  String get description => _description;

  List<TaskModel> get tasks => _tasks;

  addTask(TaskModel task) {
    _tasks.add(task);
  }

  removeTask(TaskModel task) {
    _tasks.remove(task);
    _tasks.removeWhere((t) => t.id == task.id);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": _title,
        "description": _description,
        "tasks": _tasks.map((task) => task.toMap()).toList()
      };
}
