
import 'package:flutter/material.dart';

import '../../../config/style_app/color_app.dart';
import 'button.dart';


class Button2 extends StatelessWidget {
  String title;
  Function()? onTap;
  double height;
  Widget? child;
  Button2({required this.title, this.onTap, this.height = 60,this.child});

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 20;
    return Container(
      height: (height + bottom),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(3, 0), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 15, left: 10,right: 10),
      child: Column(
        children: [
          child ?? Container(),
          Button1(title: title,textColor: Colors.white,color: ColorApp.main,onTap: onTap),
        ],
      ),
    );
  }
}
