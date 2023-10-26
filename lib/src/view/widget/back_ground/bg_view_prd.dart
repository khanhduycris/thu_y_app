import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';
import 'package:thu_y_app/src/view/widget/products/list_prd_grid.dart';

import '../../../config/image_path.dart';
import '../../../config/style_app/init_style.dart';

class BgViewHome extends StatelessWidget {
  String title;
  Widget child;
  String? banner;
  Function()? bannerSeeMore;

  BgViewHome({
    required this.child,
    required this.title,
    this.banner,
    this.bannerSeeMore,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (banner != null)
          Row(
            children: [
              GestureDetector(
                onTap: bannerSeeMore,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: ColorApp.blue1D,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.double_arrow_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'XEM\n',
                              style: StyleApp.textStyle400(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'chi tiết',
                              style: StyleApp.textStyle400(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              3.width,
              ImageNetWorkView(
                imageUrl: banner!,
                fit: BoxFit.cover,
              ).expand(),
            ],
          ).withHeight(60).paddingBottom(10),
        Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10.35),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: ColorApp.blue04, width: 2),
                    ),
                  ),
                  child: child,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ImagePath.bgPrdView,
                    height: 40,
                    width: 285,
                  ),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Row(
                      children: [
                        Image.asset(
                          ImagePath.flashIconLeft,
                          height: 30,
                        ),
                        Expanded(
                          child: Text(
                            title.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: StyleApp.textStyle500(
                                color: Colors.white, fontSize: 15.76),
                          ),
                        ),
                        Image.asset(
                          ImagePath.flashIcon,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
