import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_detail_prd.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

import 'slide_show_product.dart';

class BuildHeader extends StatelessWidget {
  ModelDetailPrd prd;

  BuildHeader({required this.prd});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SlideShow(
            list: (prd.photos ?? []).map((e) => e.path.validate()).toList(),
          ).withHeight(280),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                prd.name.validate(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleApp.textStyle700(
                  color: ColorApp.grey4F,
                ),
              ),
              5.height,
              Wrap(
                //alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 5,
                spacing: 10,
                children: [
                  Text(
                    prd.mainPrice.validate(value: "0đ"),
                    style: StyleApp.textStyle700(
                      color: ColorApp.main,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    prd.strokedPrice.validate(value: "0đ"),
                    style: StyleApp.textStyle400(
                      color: ColorApp.grey4F,
                      fontSize: 14,
                    ).copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  if (prd.discountPercent.validate() > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: ShapeDecoration(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      child: Text(
                        'Giảm ${prd.discountPercent.validate()}%',
                        style: StyleApp.textStyle500(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    )
                ],
              ),
              if (prd.link.validate().isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    Share.share(prd.link.validate());
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(
                    Icons.link,
                    color: ColorApp.blue90,
                  ),
                  label: Text(
                    "Link chia sẻ",
                    style: StyleApp.textStyle400(
                      color: ColorApp.blue04,
                      fontSize: 12,
                    ),
                  ),
                ).withHeight(25),
            ],
          ).paddingSymmetric(
            horizontal: 10,
            vertical: 15,
          ),
        ],
      ),
    );
  }
}
