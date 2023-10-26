import 'package:flutter/material.dart';
import 'package:thu_y_app/src/view/widget/products/list_prd_grid.dart';
import '../../../../../blocs/remote_bloc/font_end/models/model_prd.dart';
import '../../../../widget/back_ground/bg_view_prd.dart';

class PrdViewHome extends StatelessWidget {
  List<ModelPrd> prds;
  int total;
  Function()? seeMore;
  String title;
  String? banner;

  PrdViewHome({
    required this.prds,
    this.total = 0,
    this.seeMore,
    required this.title,
    this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return BgViewHome(
      title: title,
      banner: banner ??
          "https://png.pngtree.com/background/20210710/original/pngtree-pet-supplies-promotion-banner-poster-picture-image_1020421.jpg",
      child: ListPrdGrid(
        prds: prds,
        total: total,
        seeMore: seeMore,
      ),
    );
  }
}
