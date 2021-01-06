import 'package:coding_test/routes/login.dart';
import 'package:coding_test/routes/signup.dart';
import 'package:coding_test/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            FlutterLogo(
              duration: Duration(seconds: 1),
              size: 100,
            ),
            Spacer(flex: 1),
            MyButton(
              text: tr('login_label'),
              width: 200,
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (ctx) => LoginRoute(),
                ));
              },
            ),
            SizedBox(height: 10),
            MyButton(
              text: tr('signup_label'),
              width: 200,
              color: Colors.blue[100],
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (ctx) => SignupRoute()),
                );
              },
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
