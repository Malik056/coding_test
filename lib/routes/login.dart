import 'package:coding_test/controllers/auth_apis.dart';
import 'package:coding_test/models/user.dart';
import 'package:coding_test/routes/extra_info.dart';
import 'package:coding_test/routes/home.dart';
import 'package:coding_test/utils/utils.dart';
import 'package:coding_test/widgets/button.dart';
import 'package:coding_test/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../globals/globals.dart' as globals;

class LoginRoute extends StatefulWidget {
  final MyUser user = MyUser();
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obsecurePassword = true;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(centerTitle: true, title: Text("Login")),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFormField(
                    hint: "Email Address",
                    label: "Email",
                    obsecureText: false,
                    prefix: Icon(Icons.mail),
                    validator: (text) {
                      var error = AuthAPIs.validateEmail(text);
                      if (error == null) {
                        widget.user.email = text;
                      }
                      return error;
                    },
                    focusNode: _emailFocusNode,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    autofocus: true,
                    prefix: Icon(Icons.lock),
                    hint: "Password",
                    label: "Password",
                    validator: (text) {
                      var error = AuthAPIs.validatePassword(text);
                      if (error == null) {
                        widget.user.password = text;
                      }
                      return error;
                    },
                    focusNode: _passwordFocusNode,
                    obsecureText: _obsecurePassword,
                    suffix: Icon(_obsecurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onSuffixPress: () {
                      setState(() {
                        _obsecurePassword = !_obsecurePassword;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    text: tr('login_label'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        var userOrError = await AuthAPIs.signIn(
                            widget.user.email, widget.user.password);
                        if (userOrError == null) {
                          setState(() {
                            _loading = false;
                          });
                          Utils.showInSnackbar(
                              _scaffoldKey, tr("general_unexpected_error"));
                          return;
                        }
                        if (userOrError.runtimeType == String) {
                          setState(() {
                            _loading = false;
                          });
                          Utils.showInSnackbar(_scaffoldKey, userOrError);
                          return;
                        } else {
                          globals.user = userOrError;
                          if (globals.user.dateOfBirth == null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (ctx) => ExtraInfoRoute()),
                                (route) => false);
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (ctx) => HomeRoute()),
                                (route) => false);
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
