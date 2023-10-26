import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/cart_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/param/add_cart_param.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_detail_prd.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/cart/sc_list_cart.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_login.dart';

import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';
import '../../home/widgets/home_widget/header_home.dart';
import '../blocs/bloc_detail_screen.dart';

class BottomNavButtonPrd extends StatelessWidget {
  ModelDetailPrd prd;
  BlocDetailScreen bloc;

  BottomNavButtonPrd({
    required this.bloc,
    required this.prd,
  });

  final cartBloc = BlocCart();
  bool isAdd = false;

  buyNow() {
    isAdd = false;
    cartBloc.addCart(
      AddCartParam(
        id: prd.id.validate(),
        qty: bloc.count,
        variant: bloc.variant == null
            ? null
            : bloc.variant.validate().substring(
                  0,
                  bloc.variant.validate().length - 1,
                ),
      ),
    );
  }

  addToCart() {
    isAdd = true;
    cartBloc.addCart(
      AddCartParam(
        id: prd.id.validate(),
        qty: bloc.count,
        variant: bloc.variant == null
            ? null
            : bloc.variant.validate().substring(
                  0,
                  bloc.variant.validate().length - 1,
                ),
      ),
    );
    print(prd.id.validate());
    print("#######vao day dau tien");
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = getBoolAsync(DbKeysLocal.isLogin);
    return BlocListener<BlocCart, CubitState>(
      bloc: cartBloc,
      listener: (context, state) {
        CheckStateBloc.checkNoLoad(
          context,
          state,
          success: () {
            context.read<BlocListCart>().reLoad();
            // if (!isAdd) {
            //   ScListCart().nextPage(context);
            // }
          },
        );
      },
      child: Container(
        height: 108,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: ColorApp.main.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 0), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    bloc.updateCount();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: ColorApp.greyF6,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      color: ColorApp.main,
                    ),
                  ).withSize(width: 30, height: 30),
                ),
                10.width,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: ColorApp.greyF6,
                  ),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: BlocBuilder<BlocDetailScreen, CubitState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Text(
                        bloc.count.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: StyleApp.textStyle700(),
                      );
                    },
                  ),
                ).withHeight(30).expand(),
                10.width,
                GestureDetector(
                  onTap: () {
                    bloc.updateCount(
                        isTang: true, countMax: prd.currentStock ?? 0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: ColorApp.main,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ).withSize(width: 30, height: 30),
                ),
              ],
            ).withHeight(30),
            2.height,
            Row(
              children: [
                ItemAcction(imagePath: ImagePath.homeChat, title: "Nhắn tin"),
                BlocBuilder<BlocCart, CubitState>(
                  bloc: cartBloc,
                  builder: (context, state) {
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: ColorApp.main,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Row(
                        children: [
                          BtnDetail(
                            onTap: buyNow,
                            // onTap: isLogin
                            //     ? () => ScLogin().nextPage(context)
                            //     : buyNow,
                            title: "Mua ngay",
                            backgroundColor: ColorApp.yellowF9,
                            isLoad:
                                state.status == BlocStatus.loading && !isAdd,
                          ).expand(),
                          BtnDetail(
                            onTap: addToCart,
                            // onTap: isLogin
                            //     ? () => ScLogin().nextPage(context)
                            //     : addToCart,
                            title: "Thêm vào\ngiỏ hàng",
                            backgroundColor: ColorApp.main,
                            isLoad: state.status == BlocStatus.loading && isAdd,
                          ).expand(),
                        ],
                      ),
                    );
                  },
                ).expand(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BtnDetail({
    required String title,
    Function()? onTap,
    Color? backgroundColor,
    bool isLoad = false,
  }) {
    return TextButton(
      onPressed: isLoad ? null : onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      child: isLoad
          ? Center(
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ).withSize(
                height: 20,
                width: 20,
              ),
            )
          : Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: StyleApp.textStyle700(color: Colors.white),
            ),
    ).withHeight(45);
  }
}
