import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Database {
  //main table name
  static const String USERS = "users";

  //sub table name
  static const String COST_DATA = "cost_data";

  //fields name
  static const String SUM = "sum";
  static const String TIME_CREATION = "created";

  static DatabaseReference reference = FirebaseDatabase.instance.reference();

  static Future<Query> queryExpense() async {
    String accountKey = await _getAccountKey();

    return reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .orderByChild(TIME_CREATION);
  }

  static Future<String> createExpenseRecord() async {
    String noteKey = await _getAccountKey();

    var mountain = <String, dynamic>{
      SUM: '',
      TIME_CREATION: _getCurrentNow(),
    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child(USERS)
        .child(noteKey)
        .child(COST_DATA)
        .push();

    reference.set(mountain);

    return reference.key;
  }

  static Future<void> saveSum(String noteId, String name) async {
    String accountKey = await _getAccountKey();

    return reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(noteId)
        .child(SUM)
        .set(name);
  }

  static Future<Query> removeExpenseRecord(String noteId) async {
    String accountKey = await _getAccountKey();

    reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(noteId)
        .remove();

    return queryExpense();
  }

  static Future<Query> removeAll() async {
    reference.remove();

    return queryExpense();
  }

  static Future<StreamSubscription<Event>> getSumStream(
      String noteId, void onData(String name)) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<Event> subscription = reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(noteId)
        .child(SUM)
        .onValue
        .listen((Event event) {
      String name = event.snapshot.value as String;
      if (name == null) {
        name = "";
      }
      onData(name);
    });

    return subscription;
  }
}

Future<String> _getAccountKey() async => 'key_example';

String _getCurrentNow() =>
    DateFormat('dd-MM-yyyy HH:mm:ss').format(new DateTime.now());
