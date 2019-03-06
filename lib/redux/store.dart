import 'package:flutter_hello_world/redux/actions/actions.dart';
import 'package:flutter_hello_world/redux/model/model.dart';
import 'package:redux/redux.dart';

Store<AppState> prepareStore() {
  return Store<AppState>(
    (AppState state, dynamic action) => _getReducers(state, action),
    initialState: AppState.initialState(),
  );
}

AppState _getReducers(AppState state, action) =>
    AppState(items: itemReducer(state.items, action));

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    for (var item in state) {
      if (item.id == -1 || item.id == -2) {
        return []..add(Item(id: action.id, body: action.item));
      }
    }

    return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.item));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return AppState.createTestList();
  }

  return state;
}
