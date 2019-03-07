import 'dart:convert';

import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadItemMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store store, action, NextDispatcher next) {
    next(action);

    loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemAction(state.items)));
  }

  Future<AppState> loadFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString('itemsState');
    if (string != null) {
      Map map = json.decode(string);
      return AppState.fromJson(map);
    }
    return AppState.initialState();
  }
}
