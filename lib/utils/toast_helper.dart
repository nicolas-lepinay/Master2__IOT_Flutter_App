import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class ToastHelper {
  static toast(
    String msg, {
    double fontSize = 17.0,
    Color? backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Constants.darker.withOpacity(0.6),
      fontSize: fontSize,
    );
  }
}
