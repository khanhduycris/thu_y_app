import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/param/search_prd_param.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/style_app/color_app.dart';
import 'package:thu_y_app/src/view/screen/list_prd/sc_search_prd.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';
import 'package:thu_y_app/src/view/widget/item/item_title.dart';
import 'package:thu_y_app/src/view/widget/list/grid_view_custom.dart';

import '../../../../../blocs/remote_bloc/font_end/models/model_brand.dart';
import '../../../../../config/api/api_path.dart';
import '../../../../../config/image_path.dart';
import '../../../../widget/item/load_shimmer.dart';
import '../../../list_prd/sc_list_prd.dart';

class CategoryHome extends StatelessWidget {
  List<Modelbrand> brands;

  CategoryHome({required this.brands});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ItemTitle(
          title: "Thương hiệu",
          // onTap: () {
          //   print("xem thêm");
          // },
        ),
        10.height,
        GridViewCustom(
          itemCount: brands.length,
          showFull: true,
          maxWight: 55,
          mainAxisExtent: 55,
          crossAxisCount: 2,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => ScListPrd(
              title: brands[index].name.validate(),
              param: SearchPrdParam(brands: brands[index].id),
            ).nextPage(context),
            child: Container(
              width: 55,
              height: 55,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0.5,
                    color: ColorApp.greyF2,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Center(
                child: ImageNetWorkView(
                  imageUrl: ApiPath.domainImage + brands[index].logo.validate(),
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ).withHeight(120)
      ],
    );
  }
}

Widget LoadingBrand() {
  return LoadShimmer(
    isLoading: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 15,
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        ),
        15.height,
        GridViewCustom(
          itemCount: 15,
          showFull: true,
          maxWight: 55,
          mainAxisExtent: 55,
          crossAxisCount: 2,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) => Container(
            width: 55,
            height: 55,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.5,
                  color: ColorApp.greyF2,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Center(
              child: Image.asset(
                ImagePath.logo,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ).withHeight(120)
      ],
    ),
  );
}
