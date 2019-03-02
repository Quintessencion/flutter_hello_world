import 'package:flutter/material.dart';

List<Widget> myList = [
  new Text('element 1'),
  new Divider(),
  new Text('element 2'),
  new Divider(),
  new Text('element 3'),
  new Divider(),
  new Text('element 4'),
  new Divider()
];

class ListBody extends StatefulWidget {
  List<String> _array = [];

  @override
  State<StatefulWidget> createState() => ListBodyState();
}

class ListBodyState extends State<ListBody> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, index) {
      print('num $index : нечетное = ${index.isOdd}');

      if (index.isOdd) {
        return new Divider();
      }

      final int i = index ~/ 2;
      print('i = $i');

      return new ListTile(
        title: new Text('$i'),
      );
    });
  }
}
