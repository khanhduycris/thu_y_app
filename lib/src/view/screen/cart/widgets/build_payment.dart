import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/view/screen/cart/widgets/layout.dart';
import 'package:thu_y_app/src/view/widget/item/dash.dart';

import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';

class BuildPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomListile(
          title: "Phương thức thanh toán:",
          path: ImagePath.paymentWallet,
          titleButton: "Lựa chọn",
        ),
        const Dash(color: ColorApp.main).paddingSymmetric(horizontal: 10),
        const SizedBox(height: 15),
        Text(
          "Thanh toán khi nhận hàng",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: StyleApp.textStyle400(color: ColorApp.blue1D),
        ).paddingSymmetric(horizontal: 10),
        const SizedBox(height: 20),
      ],
    );
  }
}
