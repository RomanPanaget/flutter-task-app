import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  NewTask({@required this.controller, @required this.onPressed, @required this.focusNode});

  final TextEditingController controller;
  final Function onPressed;
  final FocusNode focusNode;

  @override
  State<StatefulWidget> createState() => NewTaskState();
}

class NewTaskState extends State<NewTask> {

  bool _addEnabled = false;

  _disableButtonIfEmpty() {
    setState(() {
      _addEnabled = widget.controller.text.isNotEmpty;
    });
  }

  _submitText() {
    widget.onPressed(widget.controller.text);
    widget.controller.text = "";
    widget.focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: TextField(
          decoration: InputDecoration(labelText: "Enter new task"),
          controller: widget.controller,
          focusNode: widget.focusNode,
          onSubmitted: (s) => _submitText(),
        ),
        contentPadding: EdgeInsets.all(0),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: _addEnabled ? _submitText : () => null,
          color: Color.fromRGBO(0, 190, 0, 1),
          highlightColor: Color.fromRGBO(0, 190, 0, 0.2),
        ));
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_disableButtonIfEmpty);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_disableButtonIfEmpty);
    super.dispose();
  }
}
