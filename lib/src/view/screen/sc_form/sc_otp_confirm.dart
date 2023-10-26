import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/bool_cubit.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/sc_form/change_pass.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';

import '../../widget/back_ground/back_ground_form.dart';
import '../../widget/input/input_otp.dart';

class ScOtpConfirm extends StatelessWidget {
  String phone;
  bool isSign;

  ScOtpConfirm({
    required this.phone,
    this.isSign = false,
  });

  String smsCode = "";
  final boolBloc = BoolCubit();

  onTap() {
    if (smsCode.length == 6) {
      boolBloc.change(true);
    } else {
      boolBloc.change(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundForm(
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
            "Xác thực mã otp".toUpperCase(),
            style: StyleApp.textStyle500(
              fontSize: 21,
              color: ColorApp.main,
            ),
          ),
          26.height,
          Text(
            "Điền mã OTP đã được gửi đến số điện thoại của bạn.",
            textAlign: TextAlign.center,
            style: StyleApp.textStyle400(
              color: ColorApp.grey4F,
            ),
          ),
          30.height,
          InputOtp(
            pinLength: 6,
            fieldWidth: 50,
            textStyle: StyleApp.textStyle400(color: ColorApp.grey4F),
            onChanged: (p0) {
              smsCode = p0;
            },
          ),
          5.height,
          BlocBuilder<BoolCubit, bool>(
            bloc: boolBloc,
            builder: (context, state) {
              if (state) {
                return const SizedBox();
              }
              return Text(
                "Vui lòng nhập đủ mã OTP.",
                textAlign: TextAlign.center,
                style: StyleApp.textStyle400(color: Colors.red, fontSize: 10),
              );
            },
          ),
          30.height,
          CustomButton(
            title: "Xác nhận",
            onTap: () {
              ScChangePass(phone: phone).nextPage(context);
            },
          ).withWidth(150),
          26.height,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Không nhận được mã OTP? ',
                  style: StyleApp.textStyle400(color: ColorApp.grey66),
                ),
                TextSpan(
                  text: 'Gửi lại.',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // resend
                    },
                  style: StyleApp.textStyle400(color: Colors.orange),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 15),
    );
  }
}
