import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/editSum.dart';
import 'package:flutter_hello_world/database/firebaseList.dart';

class FirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: ThemeData.dark(),
      home: FirebaseList(),
      routes: <String, WidgetBuilder>{
        EditSumPage.routeName: (context) => EditSumPage()
      },
    );
  }
}
