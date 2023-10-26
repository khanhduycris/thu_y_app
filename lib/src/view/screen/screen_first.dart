import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/style_app/color_app.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_login.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_sign.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import '../../config/image_path.dart';

class ScreenFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              ImagePath.formBackground,
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            Image.asset(
              ImagePath.formAvatarSplash,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                ImagePath.formTop,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                ImagePath.formTim,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.1,
              child: Image.asset(
                ImagePath.logo,
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                ImagePath.formBanChan,
              ),
            ),
            Positioned(
              bottom: size.height * 0.08,
              child: DoubleButton(context),
            )
          ],
        ),
      ),
    );
  }

  Column DoubleButton(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () {
              ScLogin().nextPage(context);
            },
            title: "Đăng nhập",
          ).withWidth(276),
          20.height,
          CustomButton(
            onTap: () {
              ScSign().nextPage(context);
            },
            title: "Đăng ký",
            color: Colors.transparent,
            textColor: ColorApp.main,
            borderSide: const BorderSide(color: ColorApp.main),
          ).withWidth(276),
        ],
      );
}
