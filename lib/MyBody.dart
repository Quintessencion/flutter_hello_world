import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  String presenter;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(children: <Widget>[
        new Text('Some text'),
        new FlatButton(
          onPressed: _onButtonPressed,
          child: new Text('Open google'),
          color: Colors.red,
          textColor: Colors.white,
        )
      ]),
    );
  }

  void _onButtonPressed() async {
    const url = 'https://google.com';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
