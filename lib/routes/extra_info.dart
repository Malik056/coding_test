import 'package:coding_test/controllers/extra_info.dart';
import 'package:coding_test/models/user.dart';
import 'package:coding_test/routes/home.dart';
import 'package:coding_test/utils/utils.dart';
import 'package:coding_test/widgets/button.dart';
import 'package:coding_test/widgets/radio_button.dart';
import 'package:coding_test/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../globals/globals.dart' as globals;

import 'auth.dart';

class ExtraInfoRoute extends StatefulWidget {
  ExtraInfoRoute({Key key}) : super(key: key);

  @override
  _ExtraInfoRouteState createState() => _ExtraInfoRouteState();
}

class _ExtraInfoRouteState extends State<ExtraInfoRoute> {
  bool _loading = false;
  int genderSelected;
  String dateOfBirth;
  String favoriteSoccerTeam;
  String favoriteDish;
  String gender;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (ctx) => AuthRoute(),
                  ),
                  (route) => false);
            },
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RadioButton(
                      value: 1,
                      groupValue: genderSelected,
                      label: tr('extra_info_male'),
                      onChanged: (value) {
                        setState(() {
                          genderSelected = value;
                          gender = "Male";
                        });
                      },
                    ),
                    RadioButton(
                        value: 2,
                        groupValue: genderSelected,
                        label: tr('extra_info_female'),
                        onChanged: (value) {
                          setState(() {
                            genderSelected = value;
                            gender = "Female";
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  label: tr('dob_label_short'),
                  hint: tr('dob_label'),
                  helperText: "Format: dd/mm/yyyy",
                  prefix: Icon(Icons.calendar_today),
                  validator: (text) {
                    if ((text ?? '').isEmpty) {
                      return tr('extra_info_dob_missing');
                    }
                    dateOfBirth = text;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  label: tr('favorite_dish_label_short'),
                  hint: tr('favorite_dish_label'),
                  prefix: Icon(Icons.sports_soccer),
                  validator: (text) {
                    if (text.isEmpty) {
                      return tr('extra_info_favorite_dish_missing');
                    }
                    favoriteDish = text;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  label: tr('favorite_soccer_team_label_short'),
                  hint: tr('favorite_soccer_team_label'),
                  prefix: Icon(Icons.sports_soccer),
                  validator: (text) {
                    if (text.isEmpty) {
                      return tr('extra_info_favorite_team_missing');
                    }
                    favoriteSoccerTeam = text;
                    return null;
                  },
                ),
                SizedBox(height: 30),
                MyButton(
                  text: tr('submit_label'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (genderSelected == null) {
                        Utils.showInSnackbar(
                            _scaffoldKey, tr("extra_info_gender_missing"),
                            bgColor: Colors.red, textColor: Colors.white);
                        return;
                      }
                      setState(() {
                        _loading = true;
                      });
                      MyUser user = MyUser();
                      user.userId = FirebaseAuth.instance.currentUser.uid;
                      user.favoriteDish = favoriteDish;
                      user.favoriteSoccerTeam = favoriteSoccerTeam;
                      user.gender = gender;
                      String error =
                          await ExtraInfoController.updateUser(globals.user);
                      if (error == null) {
                        globals.user.gender = gender;
                        globals.user.favoriteSoccerTeam = favoriteSoccerTeam;
                        globals.user.favoriteDish = favoriteDish;
                        globals.user.dateOfBirth = dateOfBirth;
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (ctx) => HomeRoute(),
                            ),
                            (route) => false);
                      } else {
                        setState(() {
                          _loading = false;
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
