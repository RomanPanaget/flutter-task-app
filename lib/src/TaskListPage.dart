import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskapp/components/TaskRow.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/src/EditTasksListPage.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key key, @required this.taskList}) : super(key: key);

  final TaskListModel taskList;

  @override
  State<StatefulWidget> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  _TaskListPageState();

  TaskListModel _taskList;

  @override
  void initState() {
    super.initState();
    _taskList = widget.taskList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_taskList.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context, _taskList);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              TaskListModel taskList = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditTasksListPage(taskList: _taskList)));
              if (taskList != null) {
                setState(() {
                  _taskList = taskList;
                });
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TaskRow(
            task: _taskList.tasks[index],
            onChecked: (checked) =>
                setState(() => _taskList.tasks[index].setDone(checked)),
          );
        },
        itemCount: _taskList.tasks.length,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }
}
