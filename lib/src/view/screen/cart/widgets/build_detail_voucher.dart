import 'package:flutter/material.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import '../../../../blocs/remote_bloc/font_end/models/model_coupon.dart';
import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';

Widget BuildDetailVoucher(ModelCoupon modelCoupon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Colors.white,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(ImagePath.detailVoucher),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Giảm",
                      style: StyleApp.textStyle700(color: Colors.white),
                    ),
                    Text(
                      "${modelCoupon.discount.formatPrice()} ${modelCoupon.discountType == "percent" ? "%" : "đ"}",
                      style: StyleApp.textStyle700(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số lần có thể sử dụng: 1",
                  style:
                      StyleApp.textStyle400(color: ColorApp.main, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  modelCoupon.code ?? "Chưa cập nhật",
                  style: StyleApp.textStyle700(
                    color: ColorApp.black33,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  "Sắp hết hạn ${modelCoupon.endDate.formatTime(format: "HH:mm - MM/dd/yyyy")}",
                  style: StyleApp.textStyle400(
                    color: ColorApp.yellowF9,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
