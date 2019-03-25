import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_world/database/BaseState.dart';
import 'package:flutter_hello_world/database/authService.dart';
import 'package:flutter_hello_world/database/editSum.dart';
import 'package:flutter_hello_world/database/firebaseList.dart';
import 'package:flutter_hello_world/database/loginButton.dart';
import 'package:flutter_hello_world/database/loginPage.dart';
import 'package:flutter_hello_world/database/registerPage.dart';
import 'package:flutter_hello_world/database/userProfile.dart';

class FirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: ThemeData.dark(),
      home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        EditSumPage.routeName: (BuildContext context) => EditSumPage(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        SignUpPage.routeName: (BuildContext context) => SignUpPage(),
        FirebaseList.routeName: (BuildContext context) => FirebaseList(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends BaseState<WelcomePage>
    with WidgetsBindingObserver {
  static const platform =
      const MethodChannel('cost_controller.flutter.io/deep_linking');

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Firebase')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () => openNamedScreen(LoginPage.routeName),
            child: Text('Sign in with Email'),
          ),
          RaisedButton(
            onPressed: () => openNamedScreen(SignUpPage.routeName),
            child: Text('Sign up with Email'),
          ),
          LoginButton(signIn, authService.signOut),
          UserProfile()
        ],
      ),
    );
  }

  signIn() {
    authService
        .googleSignIn()
        .then((user) => openScreen(FirebaseList(user: user)))
        .catchError((error) => showToast(error.message));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    authService.signOut();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      _getIntent();
    }
  }

  Future<void> _getIntent() async {
    try {
      final String result = await platform.invokeMethod("getDeepLinkingKey");

      String userUid = result.split("=")[1];
      openScreen(FirebaseList(userUid: userUid));
    } catch (e) {
      print("Deep linking: data is empty");
    }
  }
}
