import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskModel.dart';

class TaskRow extends StatefulWidget {
  TaskRow(
      {this.task,
      this.isEditMode = false,
      this.onRemove,
      this.onChecked});

  final TaskModel task;
  final bool isEditMode;
  final Function onRemove;
  final Function onChecked;

  @override
  State<StatefulWidget> createState() => TaskRowState();
}

class TaskRowState extends State<TaskRow> {
  bool _checked;
  bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _checked = widget.task.done;
    _isEditMode = widget.isEditMode;
  }

  @override
  Widget build(BuildContext context) {
    return _isEditMode
        ? ListTile(
            title: Text(widget.task.title),
            contentPadding: EdgeInsets.all(0),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: widget.onRemove,
              color: Color.fromRGBO(190, 0, 0, 1),
              highlightColor: Color.fromRGBO(190, 0, 0, 0.2),
            ))
        : CheckboxListTile(
            title: Text(widget.task.title),
            value: _checked,
            onChanged: (v) {
              _checked = v;
              widget.onChecked(v);
            });
  }
}
