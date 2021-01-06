import 'package:flutter/material.dart';

class Utils {
  static void showInSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String text,
      {Color bgColor, Color textColor, Duration duration}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: textColor ?? Colors.white)),
        backgroundColor: bgColor ?? Colors.black,
        duration: duration ?? Duration(seconds: 3),
      ),
    );
  }
}
