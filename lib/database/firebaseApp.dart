import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/BaseState.dart';
import 'package:flutter_hello_world/database/database.dart';
import 'package:flutter_hello_world/database/editSum.dart';

class FirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData.dark(),
      home: ListExpense(),
      routes: <String, WidgetBuilder>{
        EditSumPage.routeName: (context) => EditSumPage()
      },
    );
  }
}

class ListExpense extends StatefulWidget {
  @override
  _ListExpenseState createState() => _ListExpenseState();
}

class _ListExpenseState extends BaseState<ListExpense> {
  Query _query;

  @override
  void initState() {
    Database.queryExpense().then((Query query) => _reInitState(query));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Text("The list is empty...");

    if (_query != null) {
      body = Column(
        children: <Widget>[
          Expanded(
              child: FirebaseAnimatedList(
            query: _query,
            itemBuilder: (
              BuildContext context,
              DataSnapshot snapshot,
              Animation<double> animation,
              int index,
            ) {
              String snapshotKey = snapshot.key;
              Map map = snapshot.value;
              String sum = map[Database.SUM] as String;
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _remove(snapshotKey),
                    ),
                    title: Text('$sum ₽'),
                    onTap: () => _edit(snapshotKey),
                  ),
                  Divider(height: 2.0),
                ],
              );
            },
          )),
          RaisedButton(
            child: Text('Delete all notes'),
            onPressed: _removeAll,
            color: Colors.white,
            textColor: Colors.black,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Costs")),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createCostRecord,
      ),
    );
  }

  _createCostRecord() => openScreen(EditSumPage());

  void _edit(String snapshotKey) {
    openScreen(EditSumPage(snapshotKey: snapshotKey));
  }

  _remove(String snapshotKey) => Database.removeCostRecord(snapshotKey)
      .then((Query query) => _reInitState(query));

  _removeAll() =>
      Database.removeAll().then((Query query) => _reInitState(query));

  _reInitState(Query query) => setState(() {
        _query = query;
      });
}
