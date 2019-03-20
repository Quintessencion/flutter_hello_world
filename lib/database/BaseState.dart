import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseState<S extends StatefulWidget> extends State<S> {
  Future<dynamic> openScreen(StatefulWidget widgetScreen) {
    return Navigator.push(
        context, new MaterialPageRoute(builder: (context) => widgetScreen));
  }

  Future<dynamic> openNamedScreen(String name) {
    return Navigator.of(context).pushNamed(name);
  }

  void openScreenClearTop(StatefulWidget widgetScreen) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => widgetScreen),
        (Route<dynamic> route) => false);
  }

  void back() {
    Navigator.pop(context);
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
