import 'package:flutter/material.dart';
import 'package:flutter_hello_world/NewsBoxFavourite.dart';

class NewBox extends StatelessWidget {
  final String _title;
  final String _text;
  String _imageUrl;
  int _num;
  bool _like;

  NewBox(this._title, this._text, {String imageUrl, int num = 0, bool like = false}) {
    _imageUrl = imageUrl;
    _num = num;
    _like = like;
  }

  @override
  Widget build(BuildContext context) {
    if (_imageUrl != null && _imageUrl != "") {
      return new Container(
        height: 100.0,
        color: Colors.lightBlueAccent,
        child: new Row(
          children: <Widget>[
            new Image.network(_imageUrl, width: 100.0, height: 100.0, fit: BoxFit.cover),
            new Expanded(
                child: new Container(
                    padding: new EdgeInsets.all(12.0),
                    child: new Column(children: <Widget>[
                      new Text(_title,
                          style: new TextStyle(fontSize: 20.0),
                          overflow: TextOverflow.ellipsis),
                      new Expanded(
                          child: new Text(
                        _text,
                        style: new TextStyle(fontSize: 16.0),
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ))
                    ]))),
            new NewsBoxFavourite(_num, _like)
          ],
        ),
      );
    } else {
      return new Container(
          height: 100.0,
          color: Colors.lightBlueAccent,
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      padding: new EdgeInsets.all(12.0),
                      child: new Column(children: <Widget>[
                        new Text(_title,
                            style: new TextStyle(fontSize: 20.0),
                            overflow: TextOverflow.ellipsis),
                        new Expanded(
                            child: new Text(
                          _text,
                          style: new TextStyle(fontSize: 16.0),
                          softWrap: true,
                          textAlign: TextAlign.start,
                        ))
                      ]))),
              new NewsBoxFavourite(_num, _like)
            ],
          ));
    }
  }
}
