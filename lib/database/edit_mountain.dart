import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/database.dart';

class EditSumPage extends StatefulWidget {
  static String routeName = '/edit_sum';

  final String noteId;

  EditSumPage({Key key, this.noteId}) : super(key: key);

  @override
  _EditSumPageState createState() => new _EditSumPageState();
}

class _EditSumPageState extends State<EditSumPage> {
  final _nameFieldTextController = new TextEditingController();

  StreamSubscription _subscriptionName;

  @override
  void initState() {
    _nameFieldTextController.clear();

    Database.getSumStream(widget.noteId, _updateSum)
        .then((StreamSubscription s) => _subscriptionName = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionName != null) {
      _subscriptionName.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit sum"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.edit),
                  labelText: "Enter sum",
                  hintText: "Enter the desired amount..."),
              onChanged: (String value) {
                Database.saveSum(widget.noteId, value);
              },
            ),
          )
        ],
      ),
    );
  }

  void _updateSum(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}
