import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_prd_best_sell.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_search_prd.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/param/search_prd_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/search_delay.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_more_list.dart';
import 'package:thu_y_app/src/view/widget/load/loading_more.dart';
import 'package:thu_y_app/src/view/widget/products/list_prd_grid.dart';

import '../../../blocs/remote_bloc/font_end/bloc_prd_flash_deal.dart';
import '../../../blocs/remote_bloc/font_end/bloc_prd_wholesale.dart';
import '../../../config/style_app/init_style.dart';
import '../../widget/list/grid_view_custom.dart';
import '../../widget/products/item_prd.dart';

class ScSearchPrd extends StatefulWidget {
  @override
  State<ScSearchPrd> createState() => _ScSearchPrdState();
}

class _ScSearchPrdState extends State<ScSearchPrd> {
  final prdBloc = BlocSearchPrd();

  final scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  final _delay = SearchDelay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Tìm kiếm sản phẩm",
        isSearch: true,
        onChange: (p0) {
          prdBloc.param.name = p0;
          _delay.debounce(() {
            prdBloc.getList();
          });
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          prdBloc.param.name = "";
          prdBloc.getList();
        },
        child: BlocBuilder<BlocSearchPrd, CubitState>(
          bloc: prdBloc,
          builder: (context, state) {
            return LoadingMore(
              height: null,
              state: state,
              reLoad: () {
                prdBloc.getList();
              },
              isMore:
                  state.status == BlocStatus.loading && prdBloc.prds.isNotEmpty,
              child: SingleChildScrollView(
                controller: scroll,
                padding: const EdgeInsets.symmetric(vertical: 10),
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
      ),
    );
  }
}
