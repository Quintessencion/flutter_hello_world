import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/BaseState.dart';
import 'package:flutter_hello_world/database/database.dart';

class EditSumPage extends StatefulWidget {
  static String routeName = '/edit_sum_page';
  Database database;
  String snapshotKey;

  EditSumPage({Key key, this.snapshotKey, this.database}) : super(key: key);

  @override
  _EditSumPageState createState() => new _EditSumPageState();
}

class _EditSumPageState extends BaseState<EditSumPage> {
  final _nameFieldTextController = new TextEditingController();
  StreamSubscription _subscriptionName;

  @override
  void initState() {
    if (widget.snapshotKey != null) {
      widget.database
          .getSumStream(widget.snapshotKey, _updateSum)
          .then((StreamSubscription s) => _subscriptionName = s);
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameFieldTextController.clear();
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
              keyboardType: TextInputType.numberWithOptions(),
              autofocus: true,
              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                icon: new Icon(Icons.edit),
                labelText: "Enter sum",
                hintText: "Enter the desired amount...",
              ),
              onSubmitted: (String value) => _submitCostRecord(value),
            ),
          )
        ],
      ),
    );
  }

  _submitCostRecord(String value) {
    if (value.isEmpty) {
      showToast("You have not entered the amount!");
      return;
    }

    if (widget.snapshotKey != null) {
      widget.database
          .saveSum(widget.snapshotKey, value)
          .then((nothing) => back());
    } else {
      widget.database.createCostRecord(value).then((nothing) => back());
    }
  }

  _updateSum(String sum) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: sum,
    );
  }
}
