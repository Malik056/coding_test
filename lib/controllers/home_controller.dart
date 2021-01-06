import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/models/image_object.dart';
import 'package:coding_test/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeRouteController {
  static final _imagePicker = ImagePicker();
  static Future<List<ImageObject>> getImages(String uid) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('images')
        .where('uid', isEqualTo: uid)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    return snapshot.docs
        .map<ImageObject>((e) => ImageObject.fromJson(e.data()))
        .toList();
  }

  static void _handleImage(BuildContext context, String uid,
      GlobalKey<ScaffoldState> scaffoldKey, PickedFile pickedImage) async {
    if (pickedImage == null) {
      BotToast.closeAllLoading();
      Navigator.of(context).pop();
    } else {
      File file = File(pickedImage.path);
      ImageObject object = ImageObject();
      object.name = '${DateTime.now().millisecondsSinceEpoch}';
      object.storagePath = "scans/$uid/${object.name}";
      object.uid = uid;
      try {
        var taskSnapshot = await FirebaseStorage.instance
            .ref("${object.storagePath}")
            .putFile(file);

        var url = await taskSnapshot.ref.getDownloadURL();
        object.url = url;
        object.file = file;
        await FirebaseFirestore.instance
            .collection('scans')
            .add(object.toJson());
        BotToast.closeAllLoading();
        Navigator.of(context).pop(object);
      } on FirebaseException catch (ex) {
        print(ex);
        Utils.showInSnackbar(scaffoldKey, ex.message,
            bgColor: Colors.red, textColor: Colors.white);
        BotToast.closeAllLoading();
        Navigator.of(context).pop();
      } catch (ex) {
        Utils.showInSnackbar(scaffoldKey, ex.toString(),
            bgColor: Colors.red, textColor: Colors.white);
        BotToast.closeAllLoading();
        Navigator.of(context).pop();
      }
    }
  }

  static Future<ImageObject> pickImage(BuildContext context, String uid,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var imageObject = await showCupertinoDialog<ImageObject>(
        context: context,
        builder: (ctx) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Please select a source for the image'),
                ),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: FlatButton(
                      onPressed: () async {
                        BotToast.showLoading();
                        var pickedImage = await _imagePicker.getImage(
                            source: ImageSource.camera);
                        _handleImage(context, uid, scaffoldKey, pickedImage);
                      },
                      child: Text('Camera'),
                    )),
                    VerticalDivider(width: 2),
                    Expanded(
                        child: FlatButton(
                      child: Text("Gallery"),
                      onPressed: () async {
                        BotToast.showLoading();
                        var pickedImage = await _imagePicker.getImage(
                            source: ImageSource.gallery);
                        _handleImage(context, uid, scaffoldKey, pickedImage);
                      },
                    )),
                  ],
                ),
              ],
            ),
          );
        });
    return imageObject;
  }
}
