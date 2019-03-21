import 'package:flutter/material.dart';
import 'package:flutter_hello_world/database/BaseState.dart';
import 'package:flutter_hello_world/database/authService.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends BaseState<UserProfile> {
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
    return Column(children: <Widget>[
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            _loading ? Colors.white : Colors.transparent),
      ),
    ]);
  }
}
