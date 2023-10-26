import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/models/user_model.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/cart/sc_list_coupon.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../screen/cart/sc_list_cart.dart';
import 'menu_search_app_bar.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget  {
  Function()? openDrawer;

  AppBarHome({this.openDrawer});

  @override
  Widget build(BuildContext context) {
    final paddingStatusBar = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(
        color: ColorApp.main,
        image: DecorationImage(
          image: AssetImage(ImagePath.appbar),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: paddingStatusBar + 5,
          ),
          Row(
            children: [
              BlocBuilder<UserLocalBloc, CubitState>(builder: (context, state) {
                UserModel? userModel = context.read<UserLocalBloc>().userModel;
                return Row(
                  children: [
                    Container(
                      height: 37,
                      width: 37,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ImageNetWorkView(
                        imageUrl: userModel?.avatar ?? "",
                        isAvatar: true,
                        height: 37,
                        width: 37,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                    5.width,
                    Text(
                      userModel?.name ?? "Đăng nhập",
                      overflow: TextOverflow.ellipsis,
                      style: StyleApp.textStyle400(color: Colors.white),
                    ).expand(),
                  ],
                ).expand();
              }),
              IconButton(
                onPressed: () {
                  ScListCoupon().nextPage(context,isLogin: getBoolAsync(DbKeysLocal.isLogin));
                },
                visualDensity: const VisualDensity(horizontal: -4),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  CupertinoIcons.gift,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  ScListCart().nextPage(context,isLogin: getBoolAsync(DbKeysLocal.isLogin));
                },
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -4),
                icon: BlocBuilder<BlocListCart, CubitState>(
                    builder: (context, snapshot) {
                  final list = context.read<BlocListCart>().carts;
                  return Badge.count(
                    count: list.length,
                    isLabelVisible: list.isNotEmpty,
                    textStyle: StyleApp.textStyle400(
                        fontSize: 10, color: Colors.white),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    alignment: const AlignmentDirectional(15, -5),
                    child: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ],
          ).paddingSymmetric(horizontal: 10),
          5.height,
          MenuSearchAppBar(
            openDrawer: openDrawer,
          ),
          10.height,
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(115);
}
