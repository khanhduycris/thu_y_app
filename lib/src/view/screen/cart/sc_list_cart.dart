import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/cart/payment_prd.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../widget/load/load_prd.dart';
import 'widgets/item_cart.dart';

class ScListCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocListCart, CubitState>(
      builder: (context, state) {
        final list = context.read<BlocListCart>().carts;
        return Scaffold(
          appBar: AppBarCustom(title: "Giỏ hàng"),
          bottomNavigationBar: list.isEmpty
              ? null
              : CustomNavBtn(
                  title: "Đặt hàng",
                  onTap: () {
                    PayMentPrd(list: list).nextPage(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Tổng cộng:",
                        style: StyleApp.textStyle600(),
                      ),
                      10.width,
                      Text(
                        "${context.read<BlocListCart>().totalPrice.formatPrice()}đ",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: StyleApp.textStyle700(
                            fontSize: 16, color: Colors.red),
                      ).expand(),
                    ],
                  ).paddingOnly(bottom: 10, right: 5, left: 5),
                ),
          body: RefreshIndicator(
            onRefresh: () => context.read<BlocListCart>().getList(),
            child: LoadPage(
              state: state,
              reLoad: context.read<BlocListCart>().getList,
              loadChild: LoadingCart(),
              child: list.isEmpty
                  ? Center(
                      child: Text(
                        "Danh sách trống",
                        style: StyleApp.textStyle400(),
                      ),
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) =>
                          ItemCart(
                        model: list[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: list.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}
