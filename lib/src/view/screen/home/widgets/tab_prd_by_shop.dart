import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_search_prd.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_category.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/home_widget/prd_hot_home.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_more_list.dart';
import 'package:thu_y_app/src/view/widget/load/loading_more.dart';

import '../../../../config/style_app/init_style.dart';
import '../../../widget/list/grid_view_custom.dart';
import '../../../widget/load/load_prd.dart';
import '../../../widget/products/item_prd.dart';

class PrdByCategory extends StatefulWidget {
  ModelCategory category;

  PrdByCategory({
    required this.category,
  });

  @override
  State<PrdByCategory> createState() => _PrdByCategoryState();
}

class _PrdByCategoryState extends State<PrdByCategory> with AutomaticKeepAliveClientMixin{
  final prdBloc = BlocSearchPrd();

  final scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prdBloc.param.categories = widget.category.id;
    prdBloc.getList();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        prdBloc.onMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroll.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await prdBloc.getList();
      },
      child: BlocBuilder<BlocSearchPrd, CubitState>(
        bloc: prdBloc,
        builder: (context, state) {
          return LoadingMore(
            height: null,
            state: state,
            reLoad: () => prdBloc.getList(),
            isMore:
                state.status == BlocStatus.loading && prdBloc.prds.isNotEmpty,
            loadChild: LoadingPrd(),
            child: SingleChildScrollView(
              controller: scroll,
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  GridViewCustom(
                    itemCount: prdBloc.prds.length,
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
                      border: Border.all(
                        color: ColorApp.greyE9,
                        width: 0.5,
                      ),
                      prd: prdBloc.prds[index],
                    ),
                  ),
                  LoadMoreList(
                    isLoad: state.status == BlocStatus.loading &&
                        prdBloc.prds.isNotEmpty,
                    isMax: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
