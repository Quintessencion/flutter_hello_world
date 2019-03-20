import 'package:flutter_hello_world/redux/model/itemState.dart';

class AddItemAction {
  final String group;
  static int _id = 0;
  final String item;

  AddItemAction(this.item, this.group) {
    _id++;
  }

  get id => _id;
}

class UpdateItemAction {
  final Item item;

  UpdateItemAction(this.item);
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {
  final String group;

  RemoveItemsAction(this.group);
}

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
