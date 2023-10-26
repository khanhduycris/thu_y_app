import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_brands.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_prd_best_sell.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_search_prd.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/param/banner_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/home_widget/header_home.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/home_widget/prd_view_home.dart';
import 'package:thu_y_app/src/view/screen/list_prd/sc_list_prd.dart';
import 'package:thu_y_app/src/view/screen/list_prd/sc_prd_flash_deal.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../../../blocs/remote_bloc/font_end/bloc_banner.dart';
import '../../../../blocs/remote_bloc/font_end/bloc_prd_flash_deal.dart';
import '../../../../blocs/remote_bloc/font_end/bloc_prd_wholesale.dart';
import '../../../widget/app_bar/app_bar_home.dart';
import '../../../widget/item/load_shimmer.dart';
import '../widgets/home_widget/category_home.dart';
import '../widgets/home_widget/prd_hot_home.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reload();
  }

  final bannerBloc = BlocBanner();
  final brandBloc = BlocBrands();
  final prdBloc = BlocSearchPrd();
  final prdFlashDealBloc = BlocPrdFlashDeal();
  final prdWholeSaleBloc = BlocPrdWholeSale();

  reload() async {
    bannerBloc.getBanner(BannerParam(position: 1));
    brandBloc.getBrand();
    prdBloc.param.sort_key = "new_arrival";
    prdBloc.getList();
    prdFlashDealBloc.getList();
    prdWholeSaleBloc.getList();
  }

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBarHome(
        openDrawer: () => Scaffold.of(context).openDrawer(),
      ),
      body: RefreshIndicator(
        onRefresh: () => reload(),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: paddingBottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<BlocBanner, CubitState>(
                bloc: bannerBloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    height: 170,
                    reLoad: () =>
                        bannerBloc.getBanner(BannerParam(position: 1)),
                    loadChild: LoadShimmer(
                      isLoading: true,
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: HeaderHome(
                      banners: bannerBloc.banners,
                    ),
                  );
                },
              ),
              BlocBuilder<BlocBrands, CubitState>(
                bloc: brandBloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    height: 150,
                    reLoad: () => brandBloc.getBrand(),
                    loadChild: LoadingBrand(),
                    child: CategoryHome(
                      brands: brandBloc.brands,
                    ),
                  );
                },
              ),
              BlocBuilder<BlocSearchPrd, CubitState>(
                bloc: prdBloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    height: 150,
                    reLoad: () => prdBloc.getList(),
                    loadChild: LoadingPrdHome(),
                    child: prdBloc.prds.isEmpty
                        ? const SizedBox()
                        : Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(ImagePath.banner),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  88.height,
                                  PrdHotHome(
                                    prds: prdBloc.prds,
                                    total: state.total,
                                    seeMore: () => ScListPrd(
                                      title: "Sản phẩm mới",
                                      param: prdBloc.param,
                                    ).nextPage(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  );
                },
              ),
              10.height,
              BlocBuilder<BlocPrdFlashDeal, CubitState>(
                bloc: prdFlashDealBloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    height: 150,
                    reLoad: () => prdFlashDealBloc.getList(),
                    loadChild: LoadingPrdHome(),
                    child: prdFlashDealBloc.prds.isEmpty
                        ? const SizedBox()
                        : PrdViewHome(
                            total: state.total,
                            title: "Siêu Khuyến mãi",
                            prds: prdFlashDealBloc.prds,
                            seeMore: () {
                              ScPrdFlashDeal().nextPage(context);
                            },
                          ),
                  );
                },
              ),
              BlocBuilder<BlocPrdWholeSale, CubitState>(
                bloc: prdWholeSaleBloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    height: 150,
                    reLoad: () => prdWholeSaleBloc.getList(),
                    loadChild: LoadingPrdHome(),
                    child: prdWholeSaleBloc.prds.isEmpty
                        ? const SizedBox()
                        : PrdViewHome(
                            total: state.total,
                            title: "Combo tiết kiệm",
                            prds: prdWholeSaleBloc.prds,
                            seeMore: () {},
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
