import 'package:flutter/material.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';

import '../../../config/style_app/init_style.dart';

class CustomNavBtn extends StatelessWidget {
  Widget? child;
  Function()? onTap;
  String title;
  bool isLoad;

  CustomNavBtn({
    this.child,
    this.onTap,
    this.isLoad = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 108,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorApp.main.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(5, 0), // changes position of shadow
          ),
        ],
      ),
      // alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(child != null) child!,
          CustomButton(
            title: title,
            onTap: onTap,
            isLoad: isLoad,
          ),
        ],
      ),
    );
  }
}
