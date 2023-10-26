import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_search_prd.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_detail_prd.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/detail/widgets/bottom_nav_button.dart';
import 'package:thu_y_app/src/view/screen/detail/widgets/option_widget.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';
import 'package:thu_y_app/src/view/widget/products/item_prd.dart';

import '../../../blocs/remote_bloc/font_end/bloc_prd_detail.dart';
import '../../../blocs/remote_bloc/font_end/models/model_prd.dart';
import '../../widget/load/load_prd.dart';
import 'blocs/bloc_detail_screen.dart';
import 'widgets/build_description.dart';
import 'widgets/build_header.dart';

class ScDetailPrd extends StatefulWidget {
  ModelPrd product;

  ScDetailPrd({required this.product});

  @override
  State<ScDetailPrd> createState() => _ScDetailPrdState();
}

class _ScDetailPrdState extends State<ScDetailPrd> {
  final bloc = BlocDetailScreen();
  final detailBloc = BlocPrdDetail();
  final prdBloc = BlocSearchPrd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailBloc.getDetai(widget.product.id.validate());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocPrdDetail, CubitState>(
      bloc: detailBloc,
      listener: (context, state) {
        CheckStateBloc.checkNoLoad(
          context,
          state,
          isShowMsg: false,
          success: () {
            prdBloc.param.categories = detailBloc.prd?.categoryId;
            prdBloc.getList();
          },
        );
      },
      child: RefreshIndicator(
        onRefresh: () => detailBloc.getDetai(widget.product.id.validate()),
        child: BlocBuilder<BlocPrdDetail, CubitState>(
          bloc: detailBloc,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ColorApp.greyF2,
              appBar: AppBarCustom(
                title: widget.product.name.validate(value: "Chi tiết sản phẩm"),
              ),
              bottomSheet: detailBloc.prd == null
                  ? null
                  : BottomNavButtonPrd(
                      bloc: bloc,
                      prd: detailBloc.prd ?? ModelDetailPrd(),
                    ),
              body: LoadPage(
                state: state,
                height: null,
                reLoad: () => detailBloc.getDetai(widget.product.id.validate()),
                loadChild: loadDetailPrd(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BuildHeader(
                        prd: detailBloc.prd ?? ModelDetailPrd(),
                      ),
                      5.height,
                      if ((detailBloc.prd?.colors ?? []).isNotEmpty ||
                          (detailBloc.prd?.choiceOptions ?? []).isNotEmpty) ...[
                        OptionWidget(
                          prd: detailBloc.prd ?? ModelDetailPrd(),
                          option: (value) {
                            bloc.getVariant(value);
                          },
                        ),
                        5.height,
                      ],
                      BuildDescription(
                        title: "Thông tin sản phẩm",
                        description: detailBloc.prd?.description,
                      ),
                      5.height,
                      BlocBuilder<BlocSearchPrd, CubitState>(
                        bloc: prdBloc,
                        builder: (context, state) {
                          return LoadPage(
                            state: state,
                            reLoad: () => prdBloc.getList(),
                            loadChild: LoadingPrdHoz(),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Sản phẩm tương tự",
                                    style: StyleApp.textStyle700(fontSize: 16),
                                  ).paddingSymmetric(
                                      horizontal: 10, vertical: 15),
                                  ListView.separated(
                                    itemCount: prdBloc.prds.length,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    separatorBuilder: (context, index) =>
                                        15.width,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => ItemPrd(
                                      prd: prdBloc.prds[index],
                                      border: Border.all(
                                        color: ColorApp.greyE9,
                                        width: 0.5,
                                      ),
                                    ).withWidth(116),
                                  ).withHeight(206),
                                  15.height,
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
