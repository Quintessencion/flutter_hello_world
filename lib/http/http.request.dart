import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HttpTestState();
}

class HttpTestState extends State {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text('Http requests')),
        body: Center(
            child: FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _makeRequest,
          child: Text('Http'),
        )));
  }

  _makeRequest() async {
    try {
      var response = await http.get(
          'https://www.googleapis.com/drive/v3/files/1i9PcKIrkaA7dR_K2q7v3Jjy_JAPXPP-F?key=???&alt=media',
          headers: {'Accept': 'application/json'});
//      var response = await http.get('https://json.flutter.su/echo');
//      var response = await http.post('https://json.flutter.su/echo', body: {
//        'name': 'first name',
//        'second name': 'second name',
//        'age': '18'
//      }, headers: {
//        'Accept': 'application/json'
//      });

      showMessage(response.statusCode.toString() + '\n\n' + response.body,
          Colors.green);
    } catch (error) {
      showMessage(error.toString(), Colors.red);
    }
  }

  showMessage(String text, Color color) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(text),
      backgroundColor: color,
    ));
  }
}
