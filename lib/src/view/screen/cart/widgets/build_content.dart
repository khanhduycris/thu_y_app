import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import '../../../../blocs/remote_bloc/font_end/models/model_coupon.dart';
import '../../../../config/style_app/init_style.dart';

Widget BuildContent(ModelCoupon modelCoupon) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        "Có hiệu lực",
        style: StyleApp.textStyle700(color: ColorApp.main, fontSize: 16),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Từ ${modelCoupon.startDate.formatTime(format: "HH:mm - MM/dd/yyyy")}"
        " đến "
        "${modelCoupon.endDate.formatTime(format: "HH:mm - MM/dd/yyyy")}",
        style: StyleApp.textStyle700(),
      ),
      5.height,
      Html(
        data: modelCoupon.description ?? "Đang cập nhật",
        style: {
          "body": Style(
            // padding: EdgeInsets.zero,
            // margin: EdgeInsets.zero,
          ),
          "p": Style(
            // padding: EdgeInsets.zero,
            // margin: EdgeInsets.zero,
          ),
        },
      ),
    ],
  );
}
