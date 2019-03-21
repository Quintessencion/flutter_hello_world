import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/authService.dart';

class LoginButton extends StatelessWidget {
  final Function onSignIn;
  final Function onSignOut;

  LoginButton(this.onSignIn, this.onSignOut);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialButton(
              onPressed: () => onSignOut(),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Signout'),
            );
          } else {
            return MaterialButton(
              onPressed: () => onSignIn(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Login with Google'),
            );
          }
        });
  }
}
