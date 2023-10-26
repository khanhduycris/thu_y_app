import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_local.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/models/user_model.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/update_user_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/validator.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';
import 'package:thu_y_app/src/view/widget/input/custom_drop_down.dart';
import 'package:thu_y_app/src/view/widget/item/button_bottom_sheet.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../blocs/remote_bloc/auth/user_bloc.dart';
import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';
import '../../../widget/input/input_title_column.dart';

class ScreenInfor extends StatefulWidget {
  @override
  State<ScreenInfor> createState() => _ScreenInforState();
}

class _ScreenInforState extends State<ScreenInfor> {
  final name = TextEditingController();
  final email = TextEditingController();
  final birthday = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  ModelLocal? gender;

  final userBloc = UserBloc();

  final _keyFrom = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var res = getJSONAsync(DbKeysLocal.user);
    if (res != {}) {
      getData(UserModel.fromJson(res));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData(UserModel? model) {
    name.text = model?.name ?? "";
    email.text = model?.email ?? "";
    phone.text = model?.phone ?? "";
    birthday.text = model?.birthday ?? "";
    gender = model?.gender != null
        ? ModelLocal(
            id: model?.gender ?? "",
            name: model?.gender ?? "",
          )
        : null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserLocalBloc>().userModel;
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, CubitState>(
          bloc: userBloc,
          listener: (context, state) {
            CheckStateBloc.checkNoLoad(
              context,
              state,
              success: () => getData(userBloc.userModel),
            );
          },
        ),
        // BlocListener<UserLocalBloc, CubitState>(
        //   listener: (context, state) {
        //     CheckStateBloc.checkNoLoad(
        //       context,
        //       state,
        //       success: () => getData(userModel),
        //     );
        //   },
        // ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarCustom(
          title: "Thông tin cá nhân",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: _keyFrom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: ColorApp.blue1D.withOpacity(0.3),
                          width: 5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            ImagePath.logo,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                10.width,
                const SizedBox(height: 20),
                InputTitleColumn(
                  label: "Họ và tên",
                  controller: name,
                  hintText: userModel?.name ?? "Chưa cập nhật",
                  validator: (p0) =>
                      ValidatorApp.checkNull(text: p0, isTextFiled: true),
                ),
                10.height,
                InputTitleColumn(
                  label: "Email",
                  controller: email,
                  hintText: userModel?.email ?? "Chưa cập nhật",
                  validator: (p0) => ValidatorApp.checkEmail(
                    text: p0,
                  ),
                ),
                10.height,
                InputTitleColumn(
                  label: "Số điện thoại",
                  controller: phone,
                  hintText: userModel?.phone ?? "Chưa cập nhật",
                  validator: (p0) => ValidatorApp.checkPhone(
                    text: p0,
                  ),
                ),
                10.height,
                InputTitleColumn(
                    label: "Ngày sinh",
                    hintText: userModel?.birthday ?? "Chưa cập nhật",
                    validator: (p0) =>
                        ValidatorApp.checkNull(text: p0, isTextFiled: true),
                    controller: birthday,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        locale: const Locale('vi'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          birthday.text =
                              "${value.day}/${value.month}/${value.year}";
                        }
                      });
                    }),
                10.height,
                // InputTitleColumn(
                //   label: "Giới tính",
                //   controller: gender,
                //   hintText: userModel?.gender ?? "Chưa cập nhật",
                //   validator: (p0) =>
                //       ValidatorApp.checkNull(text: p0, isTextFiled: true),
                //   suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                //   onTap: () {},
                // ),
                Text(
                  "Giới tính",
                  textAlign: TextAlign.left,
                  style: StyleApp.textStyle700(),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  listItem: Listgender,
                  hint: userModel?.gender ?? "Chưa cập nhật",
                  value: gender,
                  radius: 5,
                  fillColor: Colors.transparent,
                  onChanged: (value) {
                    gender = value;
                    setState(() {});
                  },
                  validator: (p0) {
                    if (p0 == null) {
                      return "Không bỏ trống";
                    }
                    return null;
                  },
                ),
                10.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<UserBloc, CubitState>(
          bloc: userBloc,
          builder: (context, state) {
            return CustomNavBtn(
              title: "Lưu",
              isLoad: state.status == BlocStatus.loading,
              onTap: () {
                if (_keyFrom.currentState!.validate()) {
                  userBloc.updateUser(
                    UpdateUserParam(
                      name: name.text,
                      email: email.text,
                      birthday: birthday.text,
                      gender: gender?.id.validate(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

List<ModelLocal> Listgender = [
  ModelLocal(id: "Nam", name: "Nam"),
  ModelLocal(id: "Nữ", name: "Nữ"),
  ModelLocal(id: "Khác", name: "Khác"),
];
