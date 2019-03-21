import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/authService.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();

    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    var text = "";
    if (_profile != null) {
      if (_profile.containsKey("displayName")) {
        text = "name: " + _profile["displayName"];
      }
      if (_profile.containsKey("uid")) {
        text = text + "\nuid: " + _profile["uid"];
      }
    }

    return Column(children: <Widget>[
      Container(padding: EdgeInsets.all(20), child: Text(text)),
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            _loading ? Colors.white : Colors.transparent),
      ),
    ]);
  }
}
