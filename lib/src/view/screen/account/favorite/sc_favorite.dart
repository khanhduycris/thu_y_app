import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/user_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

import '../../../../blocs/remote_bloc/font_end/models/model_prd.dart';
import '../../../../config/style_app/init_style.dart';
import '../../../widget/list/grid_view_custom.dart';
import '../../detail/detail_prd.dart';

List<ModelPrd> list =[];
class ScreenFavorite extends StatelessWidget {

  final userbloc = UserBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarCustom(title: "Sản phẩm yêu thích"),);
    //   body: BlocBuilder<UserBloc,CubitState>(
    //     bloc: userbloc,
    //     builder: (context, state) {
    //       return list.isNotEmpty ? GridViewCustom(
    //         itemCount: list.length,
    //         showFull: true,
    //         shrinkWrap: true,
    //         padding: const EdgeInsets.all(15),
    //         physics: const NeverScrollableScrollPhysics(),
    //         maxWight: 170,
    //         controller: ScrollController(),
    //         mainAxisExtent: 290,
    //         crossAxisSpacing: 10,
    //         mainAxisSpacing: 10,
    //         itemBuilder: (context, index) => ScDetailPrd(),
    //       ) : Center(
    //         child: Text(
    //           "Danh mục rỗng",
    //           textAlign: TextAlign.center,
    //           style: StyleApp.textStyle400(),
    //         ),
    //       );
    //     }
    // ));
  }
}
