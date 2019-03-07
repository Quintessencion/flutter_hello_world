import 'dart:convert';

import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveStateItemMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  }

  void saveToPrefs(AppState state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = json.encode(state.toJson());
    await preferences.setString('itemsState', string);
  }
}
