import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskapp/models/TaskListsModel.dart';
import 'package:fluttertaskapp/src/TasksListsPage.dart';
import 'package:fluttertaskapp/storage/LocalStorage.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    onStart();
  }

  void onStart() async {
    LocalStorage storage = new LocalStorage();
    await storage.initDatabase();
    await Provider.of<TaskListsModel>(context, listen: false).init(storage);
    print(jsonEncode(
        Provider.of<TaskListsModel>(context, listen: false).toMap()));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TasksListsPage(title: "Flutter Tasks App")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Splash"),
        ),
        body: Text("Splash"));
  }
}
