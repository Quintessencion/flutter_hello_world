import 'dart:convert';

import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/middleware/loadItemMiddleware.dart';
import 'package:flutter_hello_world/redux/middleware/saveStateItemMiddleware.dart';
import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> appStateMiddleware(
//    [AppState state = const AppState(items: [])]
    ) {
//  final Middleware<AppState> loadItems = _loadFromPrefs(state);
//  final Middleware<AppState> saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(SaveStateItemMiddleware()),
    TypedMiddleware<AppState, RemoveItemAction>(SaveStateItemMiddleware()),
    TypedMiddleware<AppState, RemoveItemsAction>(SaveStateItemMiddleware()),
    TypedMiddleware<AppState, GitItemsAction>(LoadItemMiddleware()),
    TypedMiddleware<AppState, ItemCompletedAction>(SaveStateItemMiddleware()),
  ];
}

//Middleware<AppState> _loadFromPrefs(AppState state) {
//  return (Store<AppState> store, action, NextDispatcher next) {
//    next(action);
//
//    loadFromPrefs()
//        .then((state) => store.dispatch(LoadedItemAction(state.items)));
//  };
//}
//
//Middleware<AppState> _saveToPrefs(AppState state) {
//  return (Store<AppState> store, action, NextDispatcher next) {
//    next(action);
//
//    saveToPrefs(store.state);
//  };
//}
//
//void saveToPrefs(AppState state) async {
//  SharedPreferences preferences = await SharedPreferences.getInstance();
//  var string = json.encode(state.toJson());
//  await preferences.setString('itemsState', string);
//}
//
//Future<AppState> loadFromPrefs() async {
//  SharedPreferences preferences = await SharedPreferences.getInstance();
//  var string = preferences.getString('itemsState');
//  if (string != null) {
//    Map map = json.decode(string);
//    return AppState.fromJson(map);
//  }
//  return AppState.initialState();
//}

//simple implementation
//void appStateMiddleware(
//    Store<AppState> store, action, NextDispatcher next) async {
//  next(action);
//
//  if (action is AddItemAction ||
//      action is RemoveItemAction ||
//      action is RemoveItemsAction) {
//    saveToPrefs(store.state);
//  }
//
//  if (action is GitItemsAction) {
//    await loadFromPrefs()
//        .then((state) => store.dispatch(LoadedItemAction(state.items)));
//  }
//}
