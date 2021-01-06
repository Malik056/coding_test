import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/models/user.dart';
import 'package:easy_localization/easy_localization.dart';

class ExtraInfoController {
  ///returns `null` if there is no error
  ///returns [String] containing error description
  static Future<String> updateUser(MyUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
      return null;
    } catch (ex) {
      print(ex);
      return tr('general_unexpected_error');
    }
  }
}
