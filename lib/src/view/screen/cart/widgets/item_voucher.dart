import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../blocs/remote_bloc/font_end/models/model_coupon.dart';
import '../../../../config/style_app/init_style.dart';

class ItemVoucher extends StatelessWidget {
  ModelCoupon model;
  Function()? onTap;

  ItemVoucher({required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorApp.greyE9,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: ImageNetWorkView(
                    imageUrl: model.image.toString(),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "HSD: ${model.endDate.formatTime(format: "dd.MM.yyyy")}",
                          style: StyleApp.textStyle600(
                            fontSize: 12,
                            color: ColorApp.grey4F,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        5.height,
                        Text(
                          model.code.validate(),
                          style: StyleApp.textStyle700(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        5.height,
                        Html(
                          data: model.description.validate(
                            value: "Giảm giá sản phẩm.",
                          ),
                          style: {
                            "body": Style(
                              // margin: EdgeInsets.zero,
                              // padding: EdgeInsets.zero,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                            "p": Style(
                              // margin: EdgeInsets.zero,
                              // padding: EdgeInsets.zero,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: const BoxDecoration(
              color: ColorApp.yellowF8,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              model.discount.formatPrice() +
                  (model.discountType == "percent" ? " %" : " đ"),
              style: StyleApp.textStyle700(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
