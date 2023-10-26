import 'package:flutter/material.dart';


import 'color_app.dart';

class StyleApp {
  StyleApp._();

  static TextStyle textStyle400({
    Color color = ColorApp.black,
    double fontSize = 14,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      //fontFamily: fontFamily,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle textStyle500({
    Color color = ColorApp.black,
    double fontSize = 14,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      //fontFamily: fontFamily,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle textStyle600({
    Color color = ColorApp.black,
    double fontSize = 14,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      //fontFamily: fontFamily,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle textStyle700({
    Color color = ColorApp.black,
    double fontSize = 14,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      //fontFamily: fontFamily,
      decoration: TextDecoration.none,
    );
  }
}
