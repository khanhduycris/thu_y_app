import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/local_bloc/bool_cubit.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/sign_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../../blocs/remote_bloc/auth/user_bloc.dart';
import '../../../config/validator.dart';
import '../../widget/back_ground/back_ground_form.dart';

class ScSign extends StatelessWidget {
  final boolBloc = BoolCubit();
  final _keyForm = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();
  final passConfirm = TextEditingController();
  final bloc = UserBloc();

  onTap() {
    if (_keyForm.currentState!.validate() && boolBloc.state) {
      bloc.sign(SignParam(
        name: name.text,
        email_or_phone: phone.text,
        password: pass.text,
      ));
    } else if (!boolBloc.state) {
      toast("Vui lòng chấp nhận điều khoản và chính xác của chúng tôi");
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
              "Đăng ký".toUpperCase(),
              style: StyleApp.textStyle500(
                fontSize: 21,
                color: ColorApp.main,
              ),
            ),
            30.height,
            InputText(
              controller: name,
              hintText: "Tên tài khoản",
              prefixIcon: const Icon(CupertinoIcons.person),
              validator: (p0) {
                return ValidatorApp.checkNull(isTextFiled: true, text: p0);
              },
            ),
            12.height,
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
                return ValidatorApp.checkPass(
                  text: pass.text,
                  text2: passConfirm.text,
                  isSign: true,
                );
              },
            ),
            12.height,
            InputText(
              controller: passConfirm,
              hintText: "Nhắc lại mật khẩu",
              prefixIcon: const Icon(Icons.lock_outline),
              textFieldType: TextFieldType.PASSWORD,
              validator: (p0) {
                return ValidatorApp.checkPass(
                  text: pass.text,
                  text2: passConfirm.text,
                  isSign: true,
                );
              },
            ),
            12.height,
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
                      boolBloc.change(value ?? false);
                    },
                  ).withHeight(30);
                },
              ),
              text: "Đồng ý điều khoản & chính sách của app",
              expandedText: true,
              textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
            ),
            12.height,
            BlocConsumer<UserBloc, CubitState>(
              bloc: bloc,
              listener: (context, state) {
                CheckStateBloc.checkNoLoad(
                  context,
                  state,
                  isShowMsg: true,
                  success: () => finish(context),
                );
              },
              builder: (context, state) {
                return CustomButton(
                  title: "Đăng ký",
                  isLoad: state.status == BlocStatus.loading,
                  onTap: () => onTap(),
                );
              },
            ).withWidth(MediaQuery.of(context).size.width),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
