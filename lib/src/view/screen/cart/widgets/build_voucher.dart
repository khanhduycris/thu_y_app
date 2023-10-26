import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/bloc_add_voucher.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_coupon.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/screen/cart/widgets/layout.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../../../blocs/remote_bloc/cart/bloc_summary.dart';
import '../../../../config/style_app/init_style.dart';
import '../sc_list_coupon.dart';

class BuildVoucher extends StatefulWidget {
  BlocSummary blocSummary;

  BuildVoucher({required this.blocSummary});

  @override
  State<BuildVoucher> createState() => _BuildVoucherState();
}

class _BuildVoucherState extends State<BuildVoucher> {
  final text = TextEditingController();

  final bloc = BlocAddVoucher();

  String? code;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BlocAddVoucher, CubitState>(
          bloc: bloc,
          listener: (context, state) {
            CheckStateBloc.check(
              context,
              state,
              isShowMsg: true,
              success: () {
                widget.blocSummary.getData();
                code = state.data;
                setState(() {});
              },
            );
          },
        ),
        BlocListener<BlocSummary, CubitState>(
          bloc: widget.blocSummary,
          listener: (context, state) {
            CheckStateBloc.checkNoLoad(
              context,
              state,
              isShowMsg: false,
              success: () {
                code = widget.blocSummary.summary?.couponCode;
                setState(() {});
              },
            );
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomListile(
            path: ImagePath.paymentVoucher,
            title: "Mã giảm giá:",
            titleButton: "Chọn hoặc nhập mã",
            onTap: () => ScListCoupon(
              isChosse: true,
            ).nextPage(context).then((value) {
              if (value is ModelCoupon) {
                bloc.addVoucher(value.code.validate());
              }
            }),
          ),
          InputText(
            radius: 5,
            hintText: code ?? "Nhập mã khuyến mại",
            controller: text,
            fillColor: Colors.transparent,
            suffixIcon: InkWell(
              onTap: () async {
                bloc.addVoucher(text.text);
                text.clear();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorApp.main,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                height: 45,
                width: 99,
                child: Text(
                  "Áp dụng",
                  style: StyleApp.textStyle700(color: Colors.white),
                ),
              ),
            ),
          ).withHeight(45).paddingSymmetric(horizontal: 10),
          20.height,
        ],
      ),
    );
  }
}
