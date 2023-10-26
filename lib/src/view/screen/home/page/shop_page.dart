import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_category.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/style_app/color_app.dart';
import 'package:thu_y_app/src/config/style_app/style_text.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_tab_shop.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/tab_prd_by_shop.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';
import 'package:thu_y_app/src/view/widget/load/load_prd.dart';

class ShopPage extends StatefulWidget {
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BlocCategory, CubitState>(
          listener: (context, state) {
            CheckStateBloc.checkNoLoad(
              context,
              state,
              isShowMsg: false,
              success: () {
                _tabController =
                    TabController(length: categories.length, vsync: this);
              },
            );
          },
        ),
        BlocListener<BlocTabShop, int>(
          listener: (context, state) {
            _tabController?.animateTo(state);
          },
        ),
      ],
      child: BlocBuilder<BlocCategory, CubitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarCustom(
              title: "Cửa hàng",
              leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            body: LoadPage(
              state: state,
              height: null,
              reLoad: () => context.read<BlocCategory>().getList(),
              loadChild: LoadingCatePrd(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    unselectedLabelStyle: StyleApp.textStyle400(),
                    labelStyle: StyleApp.textStyle700(fontSize: 16),
                    labelColor: ColorApp.black,
                    unselectedLabelColor: ColorApp.grey4F,
                    indicatorColor: ColorApp.main,
                    dividerColor: ColorApp.greyF2,
                    tabs: List.generate(
                      categories.length,
                      (index) => Tab(
                        text: categories[index].name.validate().toUpperCase(),
                      ),
                    ),
                  ).withHeight(35),
                  TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        categories.length,
                        (index) => PrdByCategory(
                          category: categories[index],
                        ),
                      ),
                  ).expand(),
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
