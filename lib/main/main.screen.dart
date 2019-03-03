import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(title: new Text('Главный экран')),
        body: new Center(
            child: Column(
          children: <Widget>[
            new RaisedButton(
                onPressed: () async {
                  bool value = await Navigator.push(
                      context,
                      new PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (context, _, __) => CustomPopup(),
                          transitionsBuilder: (___, animation, ____, child) {
                            return FadeTransition(
                                opacity: animation,
//                                child: child);
                                child: new ScaleTransition(
                                    scale: animation, child: child));
                          }));
                  if (value) {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text('Больше'),
                        backgroundColor: Colors.green));
                  } else {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text('Меньше'),
                        backgroundColor: Colors.red));
                  }
                },
                child: new Text('Загадать число')),
            new RaisedButton(
                onPressed: () => _openNextScreen(context),
                child: new Text('Открыть второе окно')),
            new RaisedButton(
                onPressed: () => _openNextScreen(context, '/second/123'),
                child: new Text('Открыть второе окно (вариант с id)'))
          ],
        )));
  }

  void _openNextScreen(BuildContext context, [String id]) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => new SecondScreen()));
    Navigator.pushNamed(context, id == null || id.isEmpty ? '/second' : id);
  }
}

class SecondScreen extends StatelessWidget {
  String _id;

  SecondScreen({String id}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    _id = _id == null || _id.isEmpty ? '' : ': ' + _id;

    return new Scaffold(
        appBar: new AppBar(title: new Text('Второй экран $_id')),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Добро пожаловать на второй экран'),
              new RaisedButton(
                onPressed: () => _onBackPressed(context),
                child: new Text('Назад'),
              )
            ],
          ),
        ));
  }

  _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Ваш ответ:'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: new Text('Больше'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: new Text('Меньше'),
        )
      ],
    );
  }
}
