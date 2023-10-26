import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/bool_cubit.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/config/validator.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_otp_confirm.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../widget/back_ground/back_ground_form.dart';
import 'change_pass.dart';

class ScForgotPass extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  final phone = TextEditingController();

  onTap(BuildContext context) {
    if (_keyForm.currentState!.validate()) {
      ScOtpConfirm(
        phone: phone.text,
      ).nextPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundForm(
      child: Form(
        key: _keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logo,
              width: 100,
              height: 100,
            ),
            40.height,
            Text(
              "Quên mật khẩu".toUpperCase(),
              style: StyleApp.textStyle500(
                fontSize: 21,
                color: ColorApp.main,
              ),
            ),
            30.height,
            InputText(
              controller: phone,
              hintText: "Số điện thoại",
              prefixIcon: const Icon(CupertinoIcons.phone),
              validator: (p0) {
                return ValidatorApp.checkPhone(text: p0);
              },
            ),
            12.height,
            CustomButton(
              title: "Gửi",
              onTap: () => onTap(context),
            ).withWidth(MediaQuery.of(context).size.width),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
