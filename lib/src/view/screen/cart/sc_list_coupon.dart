import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/cart/detail_voucher.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../../blocs/remote_bloc/font_end/bloc_coupon.dart';
import '../../../config/style_app/init_style.dart';
import '../../widget/list/grid_view_custom.dart';
import 'widgets/item_voucher.dart';

class ScListCoupon extends StatelessWidget {
  bool isChosse;

  ScListCoupon({this.isChosse = false});

  final blocCoupon = BlocCoupon()..getList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Danh sách quà tặng",
      ),
      body: BlocBuilder<BlocCoupon, CubitState>(
        bloc: blocCoupon,
        builder: (_, state) {
          return LoadPage(
            state: state,
            height: null,
            reLoad: () => blocCoupon.getList(),
            child: blocCoupon.list.isNotEmpty
                ? GridViewCustom(
                    itemCount: blocCoupon.list.length,
                    itemBuilder: (_, index) => ItemVoucher(
                      model: blocCoupon.list[index],
                      onTap: () {
                        if (isChosse) {
                          finish(context, blocCoupon.list[index]);
                        } else {
                          DetailVoucher(model: blocCoupon.list[index]).nextPage(
                            context,
                            isLogin: getBoolAsync(DbKeysLocal.isLogin),
                          );
                        }
                      },
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200,
                    maxWight: 160,
                    showFull: true,
                  )
                : Center(
                    child: Text(
                      "Danh sách trống",
                      style: StyleApp.textStyle400(),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
