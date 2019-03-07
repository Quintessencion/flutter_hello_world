import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:redux/redux.dart';

class TestMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    next(action);
  }
}
