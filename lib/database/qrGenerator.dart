import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  final FirebaseUser user;

  GenerateScreen(this.user);

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  static const platform =
      const MethodChannel('cost_controller.flutter.io/message');

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Ку-ку, сука, MF!";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _sendMessage() async {
    try {
      platform.invokeMethod("sendMessage",
          {"uri": "http://www.cost-controller.com/id=${widget.user.uid}"});
    } on PlatformException catch (error) {
      print("Message sending: ${error.message}");
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.cyanAccent,
                      cursorRadius: Radius.circular(16.0),
                      controller: _textController,
                      decoration: InputDecoration(
                        helperText: "The string will be decoded into QR",
                        helperStyle: TextStyle(color: Colors.black12),
                        hintText: "Enter a custom message",
                        hintStyle: TextStyle(color: Colors.black12),
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      color: Colors.black,
                      child: Text("SUBMIT"),
                      onPressed: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: _createQRImage(bodyHeight),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createQRImage(double bodyHeight) {
    return QrImage(
      data: "app://cost-controller/id=${widget.user.uid}",
      size: 0.5 * bodyHeight,
      onError: (ex) {
        print("[QR] ERROR - $ex");
        setState(() {
          _inputErrorText = "Error! Maybe your input value is too long?";
        });
      },
    );
  }
}
