import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ClockState();
}

class ClockState extends State {
  SandGlass clock = new SandGlass();

  @override
  void initState() {
    super.initState();
    clock.tick();
  }

  _redrawWidget() async {
    if (clock.time() == 0) {
      return;
    }

    await Future.delayed(Duration(seconds: 1));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _redrawWidget();
    return new Center(child: new Text('time is: ${clock.time()}'));
  }
}

class SandGlass {
  int _sand = 0;

  time() {
    return _sand;
  }

  Future<bool> tick() async {
    _sand = 1000;

    while (_sand > 0) {
      _sand--;
      await new Future.delayed(Duration(milliseconds: 100));
    }
    return true;
  }
}
