import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/middleware/middleware.dart';
import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:flutter_hello_world/redux/model/itemState.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

DevToolsStore<AppState> prepareStore() {
  return DevToolsStore<AppState>(
    (AppState state, dynamic action) => _getReducers(state, action),
    middleware: [appStateMiddleware],
    initialState: AppState.initialState(),
  );
}

AppState _getReducers(AppState state, action) =>
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
    return List.unmodifiable([]);
  }

  if (action is LoadedItemAction) {
    return action.items;
  }

  return state;
}
