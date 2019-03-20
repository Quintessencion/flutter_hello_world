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

  final String uid;

  Database(this.uid);

  DatabaseReference reference = FirebaseDatabase.instance.reference();

  Future<Query> queryExpense() async {
    String accountKey = await _getAccountKey();

    return reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .orderByChild(TIME_CREATION);
  }

  Future<void> createCostRecord(String value) async {
    String accountKey = await _getAccountKey();

    var note = <String, dynamic>{
      SUM: value,
      TIME_CREATION: _getCurrentNow(),
    };

    reference.child(USERS).child(accountKey).child(COST_DATA).push().set(note);
  }

  Future<void> saveSum(String snapshotKey, String sum) async {
    String accountKey = await _getAccountKey();

    return reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(snapshotKey)
        .child(SUM)
        .set(sum);
  }

  Future<Query> removeCostRecord(String snapshotKey) async {
    String accountKey = await _getAccountKey();

    reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(snapshotKey)
        .remove();

    return queryExpense();
  }

  Future<Query> removeAll() async {
    reference.remove();

    return queryExpense();
  }

  Future<StreamSubscription<Event>> getSumStream(
      String snapshotKey, void onData(String name)) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<Event> subscription = reference
        .child(USERS)
        .child(accountKey)
        .child(COST_DATA)
        .child(snapshotKey)
        .child(SUM)
        .onValue
        .listen((Event event) {
      String sum = event.snapshot.value as String;
      onData(sum == null ? "" : sum);
    });

    return subscription;
  }

  Future<String> _getAccountKey() async => uid;
}

String _getCurrentNow() =>
    DateFormat('dd-MM-yyyy HH:mm:ss').format(new DateTime.now());
