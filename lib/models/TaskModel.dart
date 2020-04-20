import 'package:uuid/uuid.dart';

class TaskModel {
  TaskModel([this._title, this._done = false]) {
    var uuid = new Uuid();
    this._id = uuid.v4();
  }

  String _id;
  String _title;
  bool _done;

  String get title => _title;

  bool get done => _done;

  String get id => this._id;

  setDone(bool done) {
    _done = done;
  }

  toggleDone() {
    _done = !_done;
  }

  Map<String, dynamic> toMap() => {"id": _id, "title": _title, "done": _done};
}
