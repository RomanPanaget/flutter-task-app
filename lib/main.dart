import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/models/TaskListsModel.dart';
import 'package:fluttertaskapp/src/TasksListsPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => TaskListsModel([TaskListModel("Title", "Description", [])]),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TasksListsPage(title: 'Flutter Tasks Lists'),
    );
  }
}

class TaskList {
  TaskList(this.title, this.description);

  String title;
  String description;
}
