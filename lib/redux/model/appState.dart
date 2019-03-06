import 'package:flutter/foundation.dart';
import 'package:flutter_hello_world/redux/model/itemState.dart';

class AppState {
  final List<Item> items;

  AppState({@required this.items});

  AppState.initialState() : items = List.unmodifiable(<Item>[]..add(Item(id: 1, body: "Test")));

  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList();

  Map toJson() => {'items': items};
}
