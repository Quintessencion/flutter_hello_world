import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return new Text('my text');
  }
}
