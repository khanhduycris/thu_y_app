import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../blocs/remote_bloc/font_end/models/model_prd.dart';
import '../../../config/style_app/init_style.dart';
import '../list/grid_view_custom.dart';
import 'item_prd.dart';

class ListPrdGrid extends StatelessWidget {
  bool isHot;
  List<ModelPrd> prds;
  Function()? seeMore;
  int total;

  ListPrdGrid({
    this.isHot = false,
    this.seeMore,
    this.total = 0,
    required this.prds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridViewCustom(
          itemCount: prds.length > 6 ? 6 : prds.length,
          showFull: true,
          maxWight: 116,
          mainAxisExtent: 206,
          shrinkWrap: true,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) => ItemPrd(
            border: isHot
                ? null
                : Border.all(
                    color: ColorApp.greyE9,
                    width: 0.5,
                  ),
            prd: prds[index],
          ),
        ),
        if (seeMore != null && total > 6)
          TextButton(
            onPressed: seeMore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Xem thêm $total sản phẩm',
                  textAlign: TextAlign.center,
                  style: StyleApp.textStyle400(
                    fontSize: 13,
                    color: isHot ? Colors.white : ColorApp.black33,
                  ),
                ),
                5.width,
                // Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Container(
                //       color: Colors.white,
                //       height: 15,
                //       width: 15,
                //     ),
                //     Icon(
                //       Icons.add_box_rounded,
                //       color: isHot ? Colors.orange : ColorApp.blue04,
                //     ),
                //   ],
                // ),
              ],
            ),
          )else 15.height,
      ],
    );
  }
}
