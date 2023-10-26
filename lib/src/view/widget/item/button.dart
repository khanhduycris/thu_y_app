import 'package:flutter/material.dart';

import '../../../config/style_app/init_style.dart';


Widget Button1({
  required String title,
  Color? color,
  double height = 45,
  double width = double.infinity,
  double radius = 45,
  double fontSize = 14,
  Border? border,
  Color textColor = Colors.white,
  Function()? onTap,
}){
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        border: border,
      ),
      child: Text(title, style: StyleApp.textStyle700(color: textColor, fontSize: fontSize),overflow: TextOverflow.ellipsis),
    ),
  );
}