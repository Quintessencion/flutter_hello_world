import 'package:flutter/material.dart';

class NewsBoxFavourite extends StatefulWidget {
  final int _num;
  final bool _like;

  NewsBoxFavourite(this._num, this._like);

  @override
  State<StatefulWidget> createState() => _NewsBoxFavouriteState(_num, _like);
}

class _NewsBoxFavouriteState extends State<NewsBoxFavourite> {
  int num;
  bool like = false;

  _NewsBoxFavouriteState(this.num, this.like);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text('В избранном\n$num', textAlign: TextAlign.center),
        new IconButton(
            icon: new Icon(
              like ? Icons.star : Icons.star_border,
              size: 30.0,
              color: Colors.lightGreenAccent,
            ),
            onPressed: pressButton)
      ],
    );
  }

  void pressButton() {
    setState(() {
      like = !like;
      num = like ? ++num : --num;
    });
  }
}
