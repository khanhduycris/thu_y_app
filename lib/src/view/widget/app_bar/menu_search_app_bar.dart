import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/category/sc_category_drawer.dart';
import 'package:thu_y_app/src/view/screen/list_prd/sc_search_prd.dart';

import '../../../config/style_app/init_style.dart';

class MenuSearchAppBar extends StatelessWidget {
  Function()? openDrawer;
  MenuSearchAppBar({this.openDrawer});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScSearchPrd().nextPage(context);
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: openDrawer ?? () {
                ScCategoryDrawer().nextPage(
                  context,
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25.88,
                      decoration: BoxDecoration(
                          color: ColorApp.main,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorApp.main, width: 1)),
                    ),
                    5.height,
                    Container(
                      width: 25.88,
                      decoration: BoxDecoration(
                          color: ColorApp.main,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorApp.main, width: 1)),
                    ),
                    5.height,
                    Container(
                      width: 25.88,
                      decoration: BoxDecoration(
                          color: ColorApp.main,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorApp.main, width: 1)),
                    ),
                    3.height,
                    Text(
                      "MENU",
                      style: StyleApp.textStyle500(
                        color: ColorApp.main,
                        fontSize: 8,
                      ).copyWith(
                        letterSpacing: 0.64,
                      ),
                    )
                  ],
                ),
              ),
            ),
            10.width,
            const Icon(
              Icons.search,
              color: ColorApp.greyBD,
            ),
            2.width,
            Text(
              'Thuốc thú y, thú cưng gì cũng có!',
              style: StyleApp.textStyle400(
                color: ColorApp.greyBD,
                fontSize: 13,
              ),
            ).expand(),
            10.width,
          ],
        ),
      ),
    );
  }
}
