// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:coding_test/controllers/auth_apis.dart';
import 'package:coding_test/controllers/extra_info.dart';
import 'package:coding_test/main.dart';
import 'package:coding_test/models/user.dart';
import 'package:coding_test/routes/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // String userId;
  // testWidgets('Run App', (tester) async {
  //   await tester.pumpWidget(MyApp());
  //   await tester.pumpAndSettle(Duration(seconds: 1));
  // });
  // group('Auth', () {
  //   testWidgets('Run App', (tester) async {
  //     await tester.pumpWidget(MyApp());
  //     await tester.pumpAndSettle(Duration(seconds: 1));
  //   });
  //   test('singup success test', () async {
  //     // await Firebase.initializeApp();
  //     var result = await AuthAPIs.signupUser(
  //         MyUser()
  //           ..email = "test@gmail.com"
  //           ..password = "123456"
  //           ..name = "Test"
  //           ..lastName = "User",
  //         (text) => "abcdef");
  //     expect(result.runtimeType, MyUser);
  //     expect(result.name, "Test");
  //     expect((result.userId as String)?.isNotEmpty, true);
  //     userId = (result as MyUser).userId;
  //   });

  //   test('singup  failed test', () async {
  //     var result = await AuthAPIs.signupUser(
  //       MyUser()
  //         ..email = "test@gmail.com"
  //         ..password = "123456"
  //         ..name = "Test"
  //         ..lastName = "User",
  //     );

  //     expect(result.runtimeType, String);

  //     expect(
  //         result,
  //         tr('firebase_auth_email_already_exists_leading') +
  //             ' test@gmail.com ' +
  //             tr('firebase_auth_email_already_exists_trailing'));
  //   });

  //   test('signin failed', () async {
  //     await FirebaseAuth.instance.signOut();
  //     MyUser user = MyUser();
  //     user.email = 'test1@gmail.com';
  //     user.password = '123456';
  //     MyUser signedInResult = await AuthAPIs.signIn(user.email, user.password);
  //     expect(signedInResult.runtimeType, String);
  //     expect(signedInResult, tr('firebase_auth_invalid_email'));
  //   });
  //   test('signin', () async {
  //     await FirebaseAuth.instance.signOut();
  //     MyUser user = MyUser();
  //     user.email = 'test@gmail.com';
  //     user.password = '123456';
  //     MyUser signedInResult = await AuthAPIs.signIn(user.email, user.password);
  //     expect(signedInResult.runtimeType, MyUser);
  //     expect(signedInResult.name, "Test");
  //   });

  //   test('email validator', () async {
  //     String result = AuthAPIs.validateEmail('test@gmail.com');
  //     expect(result, null);

  //     result = AuthAPIs.validateEmail('');
  //     expect(result, tr('email_validator_empty_email'));

  //     result = AuthAPIs.validateEmail('taha.com.@gmail.com');
  //     expect(result, tr('email_validator_invalid_format'));
  //   });
  // });
  // group('Extra Info Upload', () {
  //   test('Update information on firebase', () {
  //     final user = MyUser()
  //       ..name = "Test"
  //       ..lastName = "User"
  //       ..email = "test@gmail.com"
  //       ..userId = userId
  //       ..favoriteDish = "Test Dish"
  //       ..favoriteSoccerTeam = "Test Team"
  //       ..gender = "Male"
  //       ..dateOfBirth = "Date Of Birth";
  //     var result = ExtraInfoController.updateUser(user);
  //     expect(result, null);
  //   });
  // });
}
