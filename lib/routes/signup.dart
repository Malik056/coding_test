import 'package:coding_test/controllers/auth_apis.dart';
import 'package:coding_test/models/user.dart';
import 'package:coding_test/routes/extra_info.dart';
import 'package:coding_test/utils/utils.dart';
import 'package:coding_test/widgets/button.dart';
import 'package:coding_test/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../globals/globals.dart' as globals;
import 'home.dart';

class SignupRoute extends StatefulWidget {
  final MyUser user = MyUser();
  SignupRoute({Key key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _passwordObsecureText = true;
  bool _confirmPasswordObsecureText = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(centerTitle: true, title: Text("Login")),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTextFormField(
                      hint: "Name",
                      label: "Name",
                      obsecureText: false,
                      prefix: Icon(Icons.mail),
                      validator: (text) {
                        var error = AuthAPIs.validateName(text);
                        if (error == null) {
                          widget.user.name = text;
                        }
                        return error;
                      },
                      focusNode: _nameFocusNode,
                    ),
                    SizedBox(height: 20),
                    MyTextFormField(
                      hint: "Last Name",
                      label: "Last Name",
                      obsecureText: false,
                      prefix: Icon(Icons.mail),
                      validator: (text) {
                        var error = AuthAPIs.validateName(text);
                        if (error == null) {
                          widget.user.lastName = text;
                        }
                        return error;
                      },
                      focusNode: _lastNameFocusNode,
                    ),
                    SizedBox(height: 20),
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
                      obsecureText: _passwordObsecureText,
                      suffix: Icon(_passwordObsecureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onSuffixPress: () {
                        setState(() {
                          _passwordObsecureText = !_passwordObsecureText;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    MyTextFormField(
                      autofocus: true,
                      prefix: Icon(Icons.lock),
                      hint: "Confirm Password",
                      label: "Confirm Password",
                      validator: (text) {
                        if (text != widget.user.password) {
                          return tr("signup_password_not_match");
                        }
                        return null;
                      },
                      focusNode: _confirmPasswordFocusNode,
                      obsecureText: _confirmPasswordObsecureText,
                      suffix: Icon(_confirmPasswordObsecureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onSuffixPress: () {
                        setState(() {
                          _confirmPasswordObsecureText =
                              !_confirmPasswordObsecureText;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      text: tr("signup_label"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var userOrError =
                              await AuthAPIs.signupUser(widget.user);
                          if (userOrError == null) {
                            Utils.showInSnackbar(
                                _scaffoldKey, tr("general_unexpected_error"));
                            setState(() {
                              loading = false;
                            });
                            return;
                          }
                          if (userOrError.runtimeType == String) {
                            Utils.showInSnackbar(_scaffoldKey, userOrError);
                            setState(() {
                              loading = false;
                            });
                            return;
                          } else {
                            globals.user = userOrError;
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (ctx) => ExtraInfoRoute()),
                                (route) => false);
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
      ),
    );
  }
}
