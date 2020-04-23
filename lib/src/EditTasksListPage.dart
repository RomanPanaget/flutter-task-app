import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskapp/components/NewTask.dart';
import 'package:fluttertaskapp/components/TaskRow.dart';
import 'package:fluttertaskapp/models/TaskListModel.dart';
import 'package:fluttertaskapp/models/TaskListsModel.dart';
import 'package:fluttertaskapp/models/TaskModel.dart';
import 'package:provider/provider.dart';

class EditTasksListPage extends StatefulWidget {
  EditTasksListPage({Key key, @required this.taskList}) : super(key: key);

  final TaskListModel taskList;

  @override
  State<StatefulWidget> createState() => _EditTasksListPageState();
}

class _EditTasksListPageState extends State<EditTasksListPage> {
  _EditTasksListPageState();

  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  List<TaskModel> _tasks;
  TextEditingController controller = TextEditingController();

  FocusNode descriptionFocusNode;
  FocusNode newTaskFocusNode;

  @override
  void initState() {
    super.initState();
    _tasks = List.from(widget.taskList.tasks.reversed);

    descriptionFocusNode = FocusNode();
    newTaskFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.taskList.title == "" ? "New Task List" : widget.taskList.title),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  TaskListsModel taskLists =
                      Provider.of<TaskListsModel>(context, listen: false);
                  TaskListModel taskList =
                      TaskListModel(_title, _description, List.from(_tasks.reversed));
                  if (widget.taskList.title != "") {
                    taskList.id = widget.taskList.id;
                    taskLists.update(taskList);
                  } else {
                    taskLists.add(taskList);
                  }
                  Navigator.pop(context, taskList);
                }
              },
            ),
          ]),
      body: ListView(children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: widget.taskList.title,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please set a title';
                      }
                      return null;
                    },
                    onSaved: (value) => setState(() => _title = value),
                    onFieldSubmitted: (s) {
                      descriptionFocusNode.requestFocus();
                    },
                  ),
                  TextFormField(
                    initialValue: widget.taskList.description,
                    decoration: InputDecoration(labelText: 'Description'),
                    focusNode: descriptionFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please set a description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    onFieldSubmitted: (s) {
                      newTaskFocusNode.requestFocus();
                    },
                  ),
                  NewTask(
                      controller: controller,
                      focusNode: newTaskFocusNode,
                      onPressed: (String newTask) => setState(() {
                            _tasks.insert(0, TaskModel(newTask, false));
                          })),
                  ListView.builder(
                    itemBuilder: (context, index) => TaskRow(
                        task: _tasks[index],
                        isEditMode: true,
                        onRemove: () => setState(() => _tasks.removeAt(index))),
                    itemCount: _tasks.length,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ),
                ])))
      ]),
    );
  }

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    newTaskFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}
