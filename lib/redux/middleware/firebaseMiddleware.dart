import 'package:flutter_hello_world/redux/model/appState.dart';
import 'package:redux/redux.dart';

class FirebaseMiddleware extends MiddlewareClass<AppState> {
//  static const String GROUP_NAME = "Items";
//  final DatabaseReference reference = FirebaseDatabase.instance.reference();

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
//    if (action is AddItemAction) {
//      reference.child(action.group).push().set({
//        'id': action.id,
//        'body': action.item,
//      });
//    }
//
//    if (action is RemoveItemAction) {
//      reference
//          .child("Group 2")
//          .orderByChild("body")
//          .equalTo(action.item.body)
//          .reference()
//          .remove();
//    }
//
//    if (action is RemoveItemsAction) {
//      reference.child(action.group).remove();
//    }

    next(action);
  }
}
