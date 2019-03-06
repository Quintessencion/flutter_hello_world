import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/middleware/middleware.dart';
import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:flutter_hello_world/redux/model/itemState.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

DevToolsStore<AppState> prepareStore() {
  return DevToolsStore<AppState>(
        (AppState state, dynamic action) => appStateReducer(state, action),
    middleware: appStateMiddleware(),
    initialState: AppState.initialState(),
  );
}

AppState appStateReducer(AppState state, action) {
  return AppState(items: itemReducer(state.items, action));
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemAction>(loadItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(loadCompletedReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) {
  return List.unmodifiable(List.from(items)
    ..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action) => [];

List<Item> loadItemsReducer(List<Item> items, LoadedItemAction action) {
  return action.items;
}

List<Item> loadCompletedReducer(List<Item> items, ItemCompletedAction action) {
  return items.map((item) =>
  item.id == action.item.id
      ? item.copyWith(completed: !item.completed)
      : item)
      .toList();
}

//simple implementation
//DevToolsStore<AppState> prepareStore() {
//  return DevToolsStore<AppState>(
//    (AppState state, dynamic action) => _getReducers(state, action),
//    middleware: appStateMiddleware(),
//    initialState: AppState.initialState(),
//  );
//}
//
//AppState _getReducers(AppState state, action) =>
//    AppState(items: itemReducer(state.items, action));
//
//List<Item> itemReducer(List<Item> state, action) {
//  if (action is AddItemAction) {
//    return []
//      ..addAll(state)
//      ..add(Item(id: action.id, body: action.item));
//  }
//
//  if (action is RemoveItemAction) {
//    return List.unmodifiable(List.from(state)..remove(action.item));
//  }
//
//  if (action is RemoveItemsAction) {
//    return List.unmodifiable([]);
//  }
//
//  if (action is LoadedItemAction) {
//    return action.items;
//  }
//
//  return state;
}
