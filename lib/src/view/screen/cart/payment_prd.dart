import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/bloc_summary.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/cart_bloc.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/cart/pay_success.dart';
import 'package:thu_y_app/src/view/screen/cart/widgets/build_voucher.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';

import '../../../blocs/remote_bloc/cart/bloc_payment.dart';
import '../../../blocs/remote_bloc/cart/models/model_cart.dart';
import '../../../config/style_app/init_style.dart';
import 'widgets/build_address.dart';
import 'widgets/build_payment.dart';
import 'widgets/item_cart.dart';
import 'widgets/layout.dart';

class PayMentPrd extends StatelessWidget {
  List<ModelCart> list;

  PayMentPrd({required this.list});

  Map body = Map();

  final blocSummary = BlocSummary()..getData();
  final blocCart = BlocCart();
  final blocPayment = BlocPayment();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BlocCart, CubitState>(
          bloc: blocCart,
          listener: (context, state) {
            CheckStateBloc.check(
              context,
              state,
              isShowMsg: true,
              success: () => blocSummary.getData(),
            );
          },
        ),
        BlocListener<BlocPayment, CubitState>(
          bloc: blocPayment,
          listener: (context, state) {
            CheckStateBloc.checkNoLoad(
              context,
              state,
              isShowMsg: true,
              success: () => PaySuccess().nextPage(context, isNewTask: true),
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarCustom(
          title: 'Thanh toán',
        ),
        bottomNavigationBar: BlocBuilder<BlocPayment, CubitState>(
          bloc: blocPayment,
          builder: (context, state) {
            return CustomNavBtn(
              title: "Thanh toán",
              onTap: () {
                blocPayment.payment();
              },
              isLoad: state.status == BlocStatus.loading,
              child: Row(
                children: [
                  Text(
                    "Tổng cộng:",
                    style: StyleApp.textStyle600(),
                  ),
                  10.width,
                  BlocBuilder<BlocSummary, CubitState>(
                    bloc: blocSummary,
                    builder: (context, state) {
                      return Text(
                        "${blocSummary.summary?.grandTotalValue.formatPrice()}đ",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: StyleApp.textStyle700(
                            fontSize: 16, color: Colors.red),
                      );
                    },
                  ).expand(),
                ],
              ).paddingOnly(bottom: 10, right: 5, left: 5),
            );
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Column(
            children: [
              Column(
                children: List.generate(
                  list.length,
                  (index) => ItemCart(
                    model: list[index],
                    showIcon: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 5, height: 0),
              BuildVoucher(blocSummary: blocSummary),
              const Divider(thickness: 5, height: 0),
              BuildAddress(
                onChange: (p0) {
                  blocCart.addAddressCart(p0.id.validate());
                },
              ),
              const Divider(thickness: 5, height: 0),
              BuildPayment(),
              const Divider(thickness: 5, height: 0),
              BlocBuilder<BlocSummary, CubitState>(
                bloc: blocSummary,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildRow(
                        title: 'Tiền tạm tính:',
                        content: blocSummary.summary?.subTotal ?? "0đ",
                      ),
                      buildRow(
                        title: 'Giảm giá:',
                        content: "- ${blocSummary.summary?.discount ?? "0đ"}",
                      ),
                      buildRow(
                        title: 'Tiền vận chuyển:',
                        content: blocSummary.summary?.shippingCost ?? "0đ",
                      ),
                      buildRow(
                        title: 'Vat / Tax:',
                        content: blocSummary.summary?.tax ?? "0đ",
                      ),
                    ],
                  ).paddingSymmetric(
                    horizontal: 10,
                    vertical: 15,
                  );
                },
              ),
              15.height,
            ],
          ),
        ),
      ),
    );
  }
}
