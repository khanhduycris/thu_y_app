import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/detail/detail_prd.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../blocs/remote_bloc/font_end/models/model_prd.dart';

class ItemPrd extends StatelessWidget {
  Border? border;
  ModelPrd prd;

  ItemPrd({
    this.border,
    required this.prd,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ScDetailPrd(product: prd ,).nextPage(context),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 206,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: border,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 104,
                  child: ImageNetWorkView(
                    imageUrl: prd.thumbnailImage.validate(),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(3),
                    ),
                  ),
                ),
                if (prd.discountPercent.validate() > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2.5),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: Text(
                      '-${prd.discountPercent.validate()}%',
                      style: StyleApp.textStyle500(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  prd.name.validate(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleApp.textStyle400(
                    color: ColorApp.grey4F,
                    fontSize: 12,
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${prd.mainPrice.validate(value: "0đ")} ',
                        style: StyleApp.textStyle700(
                          color: ColorApp.black33,
                          fontSize: 12,
                        ),
                      ),
                      if (prd.discountPercent.validate() > 0)
                        TextSpan(
                          text: prd.strokedPrice.validate(value: "0đ"),
                          style: StyleApp.textStyle400(
                            color: ColorApp.greyBD,
                            fontSize: 10,
                          ).copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 8, vertical: 5).expand(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: ColorApp.black33.withOpacity(0.1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              child: Text(
                'MUA',
                style: StyleApp.textStyle500(
                  color: ColorApp.black33,
                ),
              ),
            ).withHeight(35),
          ],
        ),
      ),
    );
  }
}
