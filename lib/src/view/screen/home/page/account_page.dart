import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/main.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/user_bloc.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/account/infor/profile.dart';
import 'package:thu_y_app/src/view/screen/account/question/sc_question.dart';
import 'package:thu_y_app/src/view/screen/address/sc_list_address.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/dialog/dialog_message.dart';

import '../../../../config/style_app/init_style.dart';
import '../../account/banking_infor/sc_banking_infor.dart';
import '../../account/change_pass/change_pass.dart';
import '../../account/share/sc_share.dart';
import '../widgets/account_widget/build_header.dart';
import '../widgets/account_widget/build_order_account.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final bloc = UserBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, CubitState>(
      bloc: bloc,
      listener: (context, state) {
        CheckStateBloc.check(
          context,
          state,
          isShowMsg: true,
          success: () {
            context.read<UserLocalBloc>().getUser();
            context.read<BlocNavHome>().changeTab(0);
          },
        );
      },
      child: Scaffold(
        appBar: AppBarCustom(title: "Tài khoản"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildHeaderAccount(),
              Text(
                "Quản lý thông tin cá nhân",
                style: StyleApp.textStyle600(color: ColorApp.black),
              ),
              const SizedBox(
                height: 5,
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  CupertinoIcons.person,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Thông tin cá nhân",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> ScreenInfor().nextPage(context),
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.location_on_outlined,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Địa chỉ",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> SCListAddress().nextPage(context),
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.favorite_border,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Sản phẩm yêu thích",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.lock_open,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Đổi mật khẩu",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> ScreenChangePass().nextPage(context),
              ),
              5.height,
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.food_bank_outlined,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Thông tin chuyển khoản",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> ScreenbankingInfor().nextPage(context),
              ),
              5.height,
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.food_bank_outlined,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Chia sẻ bạn bè",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> ScreenShare().nextPage(context),
              ),
              Text(
                "Quản lý đơn hàng",
                style: StyleApp.textStyle600(color: ColorApp.black),
              ),
              BuildOrderAccount(context),
              Text(
                "Cài đặt",
                style: StyleApp.textStyle600(color: ColorApp.black),
              ),
              const SizedBox(
                height: 5,
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.settings,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Thông tin phiên bản $version",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  CupertinoIcons.question_circle,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Câu hỏi thường gặp",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: ()=> const ScreenQuestion().nextPage(context),
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  CupertinoIcons.trash_fill,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Xóa tài khoản",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: () {
                  DialogMessage(
                    context: context,
                    title: "Xóa tài khoản",
                    message: "Bạn có muôn xóa tài khoản tài khoản này không?",
                    onConfirm: () {
                      finish(context);
                      bloc.removeUser();
                    },
                  );
                },
              ),
              TextIcon(
                expandedText: true,
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                prefix: const Icon(
                  Icons.logout,
                  color: ColorApp.grey66,
                  size: 20,
                ),
                text: "Đăng xuất",
                textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                onTap: () {
                  DialogMessage(
                    context: context,
                    title: "Đăng xuất",
                    message: "Bạn có muôn đăng xuất tài khoản này không?",
                    onConfirm: () {
                      finish(context);
                      bloc.logOut();
                    },
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
