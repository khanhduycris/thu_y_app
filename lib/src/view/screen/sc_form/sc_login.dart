import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/local_bloc/bool_cubit.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/login_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/config/validator.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import 'package:thu_y_app/src/view/screen/home/screen_home.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_forgot_pass.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_sign.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../../blocs/remote_bloc/auth/user_bloc.dart';
import '../../widget/back_ground/back_ground_form.dart';

class ScLogin extends StatelessWidget {
  final boolBloc = BoolCubit()..change(true);
  final _keyForm = GlobalKey<FormState>();
  final phone = TextEditingController();
  final pass = TextEditingController();
  final bloc = UserBloc();

  onTap() {
    if (_keyForm.currentState!.validate()) {
      // setValue(DbKeysLocal.isLogin, boolBloc.state);
      bloc.login(LoginParam(phone: phone.text, pass: pass.text));
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
              "Đăng nhập".toUpperCase(),
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
            InputText(
              controller: pass,
              hintText: "Mật khẩu",
              prefixIcon: const Icon(Icons.lock_outline),
              textFieldType: TextFieldType.PASSWORD,
              validator: (p0) {
                return ValidatorApp.checkPass(text: p0);
              },
            ),
            12.height,
            Row(
              children: [
                TextIcon(
                  prefix: BlocBuilder<BoolCubit, bool>(
                    bloc: boolBloc,
                    builder: (context, state) {
                      return Checkbox(
                        value: state,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        activeColor: ColorApp.main,
                        onChanged: (value) {
                          // boolBloc.change(value ?? false);
                        },
                      ).withHeight(30);
                    },
                  ),
                  text: "Ghi nhớ mật khẩu",
                  expandedText: true,
                  textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                ).expand(),
                10.width,
                TextButton(
                  onPressed: () {
                    ScForgotPass().nextPage(context);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "Quên mật khẩu?",
                    style: StyleApp.textStyle400(color: Colors.orange),
                  ),
                ),
              ],
            ).withHeight(30),
            12.height,
            BlocConsumer<UserBloc, CubitState>(
              bloc: bloc,
              listener: (context, state) {
                CheckStateBloc.checkNoLoad(
                  context,
                  state,
                  isShowMsg: true,
                  success: () {
                    // context.read<BlocNavHome>().changeTab(0);
                    // context.read<UserLocalBloc>().getUser();
                    ScreenHome().nextPage(context, isNewTask: true);
                  },
                );
              },
              builder: (context, state) {
                return CustomButton(
                  title: "Đăng nhập",
                  onTap: onTap,
                  isLoad: state.status == BlocStatus.loading,
                );
              },
            ).withWidth(MediaQuery.of(context).size.width),
            16.height,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Bạn chưa có tài khoản? ',
                    style: StyleApp.textStyle400(color: ColorApp.grey66),
                  ),
                  TextSpan(
                    text: 'Đăng ký ngay.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ScSign().nextPage(context);
                      },
                    style: StyleApp.textStyle400(color: Colors.orange),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
