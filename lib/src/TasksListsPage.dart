import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/models/TaskListsModel.dart';
import 'package:fluttertaskapp/src/EditTasksListPage.dart';
import 'package:fluttertaskapp/src/TaskListPage.dart';
import 'package:provider/provider.dart';

class TasksListsPage extends StatefulWidget {
  TasksListsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TasksListsPageState createState() => _TasksListsPageState();
}

class _TasksListsPageState extends State<TasksListsPage> {
  Widget _buildRow(TaskListsModel taskLists, int index) {
    TaskListModel taskList = taskLists.items[index];
    return ListTile(
      title: Text(taskList.title),
      subtitle: Text(taskList.description),
      onTap: () async {
        final TaskListModel updatedTaskList = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TaskListPage(taskList: taskList)));
        taskLists.update(updatedTaskList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<TaskListsModel>(
        builder: (context, taskLists, child) {
          return ListView.builder(
              itemBuilder: (context, i) {
                return _buildRow(taskLists, i);
              },
              itemCount: taskLists.items.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditTasksListPage(taskList: TaskListModel("", "", []))));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
