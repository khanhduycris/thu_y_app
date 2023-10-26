import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/color_app.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/list_prd/sc_list_prd.dart';
import 'package:thu_y_app/src/view/widget/list/grid_view_custom.dart';

import '../../../../../blocs/remote_bloc/font_end/models/model_prd.dart';
import '../../../../widget/item/load_shimmer.dart';
import '../../../../widget/products/item_prd.dart';
import '../../../../widget/products/list_prd_grid.dart';

class PrdHotHome extends StatelessWidget {
  List<ModelPrd> prds;
  int total;
  Function()? seeMore;

  PrdHotHome({
    required this.prds,
    this.seeMore,
    this.total = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: ColorApp.blue11,
        image: DecorationImage(
          image: AssetImage(ImagePath.bgHotHome),
          alignment: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                Image.asset(
                  ImagePath.chanMeo,
                  height: 15,
                  width: 15,
                ),
                7.width,
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Sản phẩm mới  ".toUpperCase(),
                        style: StyleApp.textStyle700(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          ImagePath.flashIcon,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ).expand(),
              ],
            ),
          ),
          ListPrdGrid(
            isHot: true,
            prds: prds,
            total: total,
            seeMore: seeMore,
          ),
        ],
      ),
    );
  }
}

Widget LoadingPrdHome() {
  return LoadShimmer(
    isLoading: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.height,
        Container(
          height: 20,
          width: 250,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        15.height,
        GridViewCustom(
          itemCount: 6,
          showFull: true,
          maxWight: 116,
          mainAxisExtent: 206,
          shrinkWrap: true,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: ColorApp.greyE9,
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 104,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.logo,
                    height: 70,
                    width: 70,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        const Spacer(),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
