import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
//    try {
//      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//      var image = await boundary.toImage();
//      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//      Uint8List pngBytes = byteData.buffer.asUint8List();
//
//      final tempDir = await getTemporaryDirectory();
//      final file = await new File('${tempDir.path}/image.png').create();
//      await file.writeAsBytes(pngBytes);
//
//      final channel = const MethodChannel('channel:me.alfian.share/share');
//      channel.invokeMethod('shareFile', 'image.png');
//
//      final ByteData bytes = await rootBundle.load('assets/dollar.png');
//      final Uint8List list = bytes.buffer.asUint8List();
//
//      final tempDir = await getTemporaryDirectory();
//      final file = await new File('${tempDir.path}/dollar.png').create();
//      file.writeAsBytesSync(list);
//
//      final channel = const MethodChannel('channel:me.albie.share/share');
//      channel.invokeMethod('shareFile', 'dollar.png');
//    } catch (e) {
//      print(e.toString());
//    }
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
