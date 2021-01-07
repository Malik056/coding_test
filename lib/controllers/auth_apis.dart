import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/controllers/validator.dart';
import 'package:coding_test/models/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthAPIs {
  /// returns Future that resolves to [MyUser] if there are no errors
  ///
  /// returns Future that resolves to [String]
  ///  containing error description when there is an error
  static Future<dynamic> signupUser(MyUser user) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      String uid = credential.user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(user.toJson(), SetOptions(merge: true));
      user.userId = uid;
      return user;
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "email-already-in-use") {
        return "${tr('firebase_auth_email_already_exists_leading')} ${user?.email ?? ""} ${tr("firebase_auth_email_already_exists_trailing")}";
      } else if (ex.code == "invalid-email") {
        return tr('firebase_auth_invalid_email_address');
      } else if (ex.code == "operation-not-allowed") {
        return "The new account signup is turned off. Please contact support";
      } else if (ex.code == "weak-password") {
        return tr("firebase_auth_weak_password");
      }
    } catch (ex) {
      print(ex);
      return tr("general_unexpected_error");
    }
  }

  ///return a [String] if there is an error which contains error description
  ///
  ///returns object of type [MyUser] if signin is Successfull
  static Future<dynamic> signIn(String email, password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user.uid;
      var snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!snapshot.exists) {
        await userCredential.user.delete();
        return tr("firebase_auth_user_not_exist");
      }
      return MyUser.fromJson(snapshot.data())..userId = userCredential.user.uid;
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "invalid-email") {
        return tr('firebase_auth_invalid_email');
      } else if (ex.code == "user-disabled") {
        return tr('firebase_auth_user_disabled');
      } else {
        return tr('firebase_auth_wrong_password');
      }
    } catch (ex) {
      print(ex);
      return tr("general_unexpected_error");
    }
  }

  static String validateName(String value) {
    if (value.isEmpty) {
      return tr('name_validator_empty_name');
    } else if (value.length < 3) {
      return tr('name_validator_not_enough_letters');
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return tr('email_validator_empty_email');
    } else if (Validators.validateEmail(value) == false) {
      return tr('email_validator_invalid_format');
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return tr('password_validator_empty_password');
    } else if (value.length < 6) {
      return tr('password_validator_not_enough_length');
    } else {
      return null;
    }
  }
}
