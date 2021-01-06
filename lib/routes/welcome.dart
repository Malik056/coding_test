import 'package:coding_test/controllers/welcome.dart';
import 'package:coding_test/models/user.dart';
import 'package:coding_test/routes/auth.dart';
import 'package:coding_test/routes/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser>(
      future: WelcomeController.getSignedInUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (snapshot.data == null) {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (ctx) => AuthRoute()),
                  (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (ctx) => HomeRoute()),
                  (route) => false);
            }
          });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
