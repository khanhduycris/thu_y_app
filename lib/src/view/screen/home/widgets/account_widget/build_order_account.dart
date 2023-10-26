import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/order/screen_order.dart';
import '../../../../../config/image_path.dart';
import '../../../../../config/style_app/init_style.dart';
import '../../../../widget/item/item_column.dart';

Widget BuildOrderAccount(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      listDataOrder.length,
      (index) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: ItemColumn(
            imagePath: listDataOrder[index].imagePath,
            title: listDataOrder[index].title,
            colorBgImage: ColorApp.blue02.withOpacity(0.1),
            onTap: () {
              ScreenOrder(page: index == 0 ? index : (index + 1),).nextPage(context,isLogin: getBoolAsync(DbKeysLocal.isLogin));
            },
          ),
        ),
      ),
    ),
  );
}

class DataOrder {
  String imagePath;
  String title;
  Function()? onTap;

  DataOrder({required this.title, required this.imagePath, this.onTap});
}

List<DataOrder> listDataOrder = [
  DataOrder(
    title: "Chờ xác nhận",
    imagePath: ImagePath.orderAwaitConfirn,
  ),
  DataOrder(
    title: "Chờ giao hàng",
    imagePath: ImagePath.orderAwaitShip,
  ),
  DataOrder(
      title: "Đang giao hàng",
      imagePath: ImagePath.orderShipping,
      onTap: () {}),
  DataOrder(
    title: "Đã giao hàng",
    imagePath: ImagePath.orderShipDone,
  ),
];
