import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/change_pass_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/screen_first.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../../blocs/remote_bloc/auth/user_bloc.dart';
import '../../../config/validator.dart';
import '../../widget/back_ground/back_ground_form.dart';

class ScChangePass extends StatelessWidget {
  String phone;

  ScChangePass({required this.phone});

  final _keyForm = GlobalKey<FormState>();
  final pass = TextEditingController();
  final passConfirm = TextEditingController();
  final bloc = UserBloc();

  onTap() {
    if (_keyForm.currentState!.validate()) {
      bloc.changePass(ChangePassParam(pass: pass.text, phone: phone));
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
              "Đổi mật khẩu".toUpperCase(),
              style: StyleApp.textStyle500(
                fontSize: 21,
                color: ColorApp.main,
              ),
            ),
            30.height,
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
            BlocConsumer<UserBloc, CubitState>(bloc: bloc,
              listener: (context, state) {
                CheckStateBloc.checkNoLoad(
                  context,
                  state,
                  success: () {
                    ScreenFirst().nextPage(context, isNewTask: true);
                  },
                );
              },
              builder: (context, state) {
                return CustomButton(
                  title: "Xác nhận",
                  onTap: onTap,
                  isLoad: state.status == BlocStatus.loading
                );
              },
            ).withWidth(MediaQuery.of(context).size.width),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
