import 'package:flutter_hello_world/redux/model/itemState.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {}

class GitItemsAction {}

class LoadedItemAction {
  final List<Item> items;

  LoadedItemAction(this.items);
}

class ItemCompletedAction {
  final Item item;

  ItemCompletedAction(this.item);
}

class ItemClickAction {
  final Item item;

  ItemClickAction(this.item);
}
