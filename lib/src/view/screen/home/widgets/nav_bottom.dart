import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';

import '../../../../config/db/db_keys_local.dart';
import '../../../../config/style_app/init_style.dart';
import '../../sc_form/sc_login.dart';

class NavBottom extends StatefulWidget {
  Function()? centerOnTap;

  NavBottom({this.centerOnTap});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.only(top: 12),
          padding: EdgeInsets.only(bottom: paddingBottom),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ColorApp.grey66.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ItemNav(
                imagePath: ImagePath.navHome,
                title: "Trang chủ",
                index: 0,
              ),
              ItemNav(
                imagePath: ImagePath.navShop,
                title: "Cửa hàng",
                index: 1,
              ),
              const Expanded(child: SizedBox()),
              ItemNav(
                imagePath: ImagePath.navNotification,
                title: "Thông báo",
                index: 2,
              ),
              ItemNav(
                imagePath: ImagePath.navAccount,
                title: "Tài khoản",
                index: 3,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: GestureDetector(
            onTap: widget.centerOnTap,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorApp.blue05,
                    ColorApp.blue02,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  ImagePath.navCard,
                  height: 19,
                  width: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ItemNav({
    required String title,
    required String imagePath,
    int index = 0,
  }) {
    return Expanded(
      child: BlocBuilder<BlocNavHome, int>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              if ((index == 2 || index == 3) &&
                  !getBoolAsync(DbKeysLocal.isLogin)) {
                ScLogin().nextPage(context);
              } else {
                context.read<BlocNavHome>().changeTab(index);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    height: 20,
                    width: 18,
                    color: state == index ? ColorApp.main : ColorApp.grey82,
                  ),
                  3.height,
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: state == index
                        ? StyleApp.textStyle700(
                            fontSize: 10,
                            color: ColorApp.main,
                          )
                        : StyleApp.textStyle400(
                            fontSize: 10,
                            color: ColorApp.grey82,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
