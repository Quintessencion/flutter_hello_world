import 'package:flutter/foundation.dart';

class AppState {
  final List<Item> items;

  AppState({@required this.items});

  AppState.initialState() : items = createTestList();

  static createTestList() {
    return <Item>[]
      ..add(Item(id: -1, body: 'Test item 1'))
      ..add(Item(id: -2, body: 'Test item 2'));
  }
}

class Item {
  final int id;
  final String body;

  Item({@required this.id, @required this.body});

  Item copyWith({int id, String body}) {
    return Item(id: id ?? this.id, body: body ?? this.body);
  }
}
