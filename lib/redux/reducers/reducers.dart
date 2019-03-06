import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/model/model.dart';

AppState appStateReducer(AppState state, action) =>
    AppState(items: itemReducer(state.items, action));

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.item));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable(List.unmodifiable([]));
  }

  return state;
}
