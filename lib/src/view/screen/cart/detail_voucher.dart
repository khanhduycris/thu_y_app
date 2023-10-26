import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/bloc_add_voucher.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/cart/payment_prd.dart';
import 'package:thu_y_app/src/view/screen/cart/widgets/build_detail_voucher.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';

import '../../../blocs/remote_bloc/cart/list_cart_bloc.dart';
import '../../../blocs/remote_bloc/font_end/models/model_coupon.dart';
import 'widgets/build_content.dart';

class DetailVoucher extends StatelessWidget {
  ModelCoupon model;

  DetailVoucher({required this.model});

  final bloc = BlocAddVoucher();

  @override
  Widget build(BuildContext context) {
    final carts = context.read<BlocListCart>().carts;
    return Scaffold(
      appBar: AppBarCustom(title: model.code ?? "Chi tiết khuyến mãi"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            BuildDetailVoucher(model),
            const SizedBox(height: 20),
            BuildContent(model),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<BlocAddVoucher, CubitState>(
        bloc: bloc,
        listener: (context, state) {
          CheckStateBloc.checkNoLoad(
            context,
            state,
            success: () => PayMentPrd(list: carts).nextPage(context),
          );
        },
        builder: (context, state) {
          return CustomNavBtn(
            title: "Dùng ngay",
            isLoad: state.status == BlocStatus.loading,
            onTap: () {
              if (carts.isNotEmpty) {
                bloc.addVoucher(model.code.validate());
              } else {
                toast(
                    "Giỏ hàng trống. Vui lòng thêm sản phẩm vào giỏ hàng để sử dụng Voucher.");
              }
            },
          );
        },
      ),
    );
  }
}
