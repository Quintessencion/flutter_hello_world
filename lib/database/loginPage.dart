import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/BaseState.dart';
import 'package:flutter_hello_world/database/firebaseList.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login_page';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (input) => _email = input,
                initialValue: 'mail@mail.ru',
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Longer password please';
                  }
                },
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (input) => _password = input,
                obscureText: true,
                initialValue: "123qwe",
              ),
              RaisedButton(
                onPressed: emailSignIn,
                child: Text('Sign in'),
              ),
            ],
          )),
    );
  }

  void emailSignIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((FirebaseUser user) {
//          openScreenClearTop(FirebaseList(user: user));
          openScreen(FirebaseList(user: user));
        });
      } catch (exception) {
        showToast(exception.message);
      }
    }
  }
}
