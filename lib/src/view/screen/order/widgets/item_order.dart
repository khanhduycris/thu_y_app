import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import 'package:thu_y_app/src/config/extension/string_ext.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../blocs/remote_bloc/order/models/model_order.dart';
import '../../../../config/style_app/init_style.dart';

class ItemOrder extends StatelessWidget {
  ModelOrder modelOrder;

  ItemOrder({required this.modelOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPrd(modelOrder.orderDetails ?? []),
        const Divider(
          thickness: 1,
          color: ColorApp.greyBD,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${modelOrder.orderDetails!.length} sản phẩm",
                style: StyleApp.textStyle400(color: ColorApp.main),
              ),
              const Spacer(),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Thành tiền:",
                style: StyleApp.textStyle400(color: ColorApp.grey4F),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${modelOrder.grandTotal.formatPrice()} đ',
                style: StyleApp.textStyle700(color: Colors.red),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: ColorApp.greyBD,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Địa chỉ nhận hàng:",
                overflow: TextOverflow.ellipsis,
                style: StyleApp.textStyle700(),
              ),
              const SizedBox(
                height: 13,
              ),
              buildRow(
                title: "Họ - Tên:",
                content: modelOrder.shippingAddress?.name ?? "Chưa cập nhật",
              ),
              buildRow(
                title: "Số điện thoại:",
                content: modelOrder.shippingAddress?.phone ?? "Chưa cập nhật",
              ),
              buildRow(
                title: "Địa chỉ:",
                content: modelOrder.shippingAddress!.address.formatAddress() +
                    modelOrder.shippingAddress!.ward.formatAddress() +
                    modelOrder.shippingAddress!.district.formatAddress() +
                    (modelOrder.shippingAddress?.province ?? ""),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: ColorApp.greyBD,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phương thức thanh toán:",
                overflow: TextOverflow.ellipsis,
                style: StyleApp.textStyle700(),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                modelOrder.paymentType == "cod_payment"
                    ? 'Thanh toán khi nhận hàng'
                    : "Đang cập nhật",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: StyleApp.textStyle400(
                  color: ColorApp.grey66,
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: ColorApp.greyBD,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phương thức vận chuyển:",
                overflow: TextOverflow.ellipsis,
                style: StyleApp.textStyle700(),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                modelOrder.shippingType.validate().isEmpty
                    ? "Chưa cập nhật"
                    : modelOrder.shippingType.validate(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: StyleApp.textStyle400(
                  color: ColorApp.grey66,
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: ColorApp.greyBD,
        ),
      ],
    );
  }

  Widget buildRow({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: StyleApp.textStyle400(
              color: ColorApp.grey66,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: StyleApp.textStyle400(
              color: ColorApp.grey4F,
            ),
          ))
        ],
      ),
    );
  }

  Widget buildPrd(List<OrderDetails> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:
          List.generate(list.length, (index) => ItemPrdOrder(list[index])),
    );
  }

  ItemPrdOrder(OrderDetails orderDetails) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: ImageNetWorkView(
              imageUrl: orderDetails.thumbnailImage.toString(),
              height: 65,
              width: 65,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  orderDetails.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: StyleApp.textStyle700(),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "x ${orderDetails.quantity.validate()}",
                  textAlign: TextAlign.right,
                  style: StyleApp.textStyle700(
                    color: ColorApp.grey66,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   Const.convertPrice(orderDetails.price) + 'đ',
                    //   style: StyleApp.textStyle400(
                    //       color: ColorApp.greyBD, fontSize: 12)
                    //       .copyWith(decoration: TextDecoration.lineThrough),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${orderDetails.price.formatPrice()} đ',
                      style: StyleApp.textStyle700(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
