import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeController {
  static Future<MyUser> getSignedInUser() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    } else {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (!userData.exists) {
        try {
          await FirebaseAuth.instance.currentUser.delete();
          await FirebaseAuth.instance.signOut();
        } catch (ex) {
          print(ex);
        }
        return null;
      }
      return MyUser.fromJson(userData.data());
    }
  }
}
