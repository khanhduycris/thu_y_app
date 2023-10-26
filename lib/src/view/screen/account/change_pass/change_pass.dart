import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/change_pass_param.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/user_bloc.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/validator.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';
import 'package:thu_y_app/src/view/widget/item/button_bottom_sheet.dart';

import '../../../../config/style_app/init_style.dart';
import '../../../widget/input/input_text.dart';

class ScreenChangePass extends StatefulWidget {
  @override
  State<ScreenChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ScreenChangePass> {
  final key = GlobalKey<FormState>();
  TextEditingController pass = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  final userbloc = UserBloc();

  changePass() {
    if (key.currentState!.validate()) {
      userbloc.changePass(
        ChangePassParam(
          old_pass: pass.text,
          pass: pass1.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, CubitState>(
      bloc: userbloc,
      listener: (context, state) {
        CheckStateBloc.checkNoLoad(context, state, success: () => finish(context),);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarCustom(title: "Đổi mật khẩu"),
          body: Form(
            key: key,
            child: Column(
              children: [
                InputText(
                  hintText: "Mật khẩu cũ*",
                  controller: pass,
                  textFieldType: TextFieldType.PASSWORD,
                  radius: 5,
                  validator: (val) {
                    return ValidatorApp.checkPass(text: val);
                  },
                ),
                15.height,
                InputText(
                  hintText: "Mật khẩu mới*",
                  controller: pass1,
                  textFieldType: TextFieldType.PASSWORD,
                  radius: 5,
                  validator: (val) {
                    return ValidatorApp.checkPass(
                        text: val, text2: pass2.text, isSign: true);
                  },
                ),
                15.height,
                InputText(
                  hintText: "Nhập lại mật khẩu mới*",
                  controller: pass2,
                  textFieldType: TextFieldType.PASSWORD,
                  radius: 5,
                  validator: (val) {
                    return ValidatorApp.checkPass(
                        text: val, text2: pass1.text, isSign: true);
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ).scrollView().paddingSymmetric(vertical: 20, horizontal: 10),
          bottomNavigationBar: CustomNavBtn(
            title: "Lưu thay đổi",
            onTap: changePass,
            isLoad: state.status == BlocStatus.loading,
          ),
        );
      },
    );
  }
}
