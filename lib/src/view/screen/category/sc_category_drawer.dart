import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_category.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_tab_shop.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../widget/item/load_shimmer.dart';

class ScCategoryDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: RefreshIndicator(
        onRefresh: () => context.read<BlocCategory>().getList(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Text(
              "Danh mục".toUpperCase(),
              style: StyleApp.textStyle700(
                fontSize: 20,
                color: ColorApp.main,
              ),
            ).paddingSymmetric(horizontal: 10, vertical: 10),
            const Divider(
              color: ColorApp.main,
              height: 0,
              thickness: 2,
            ),
            BlocBuilder<BlocCategory, CubitState>(
              builder: (context, state) {
                return LoadPage(
                  state: state,
                  height: null,
                  reLoad: () => context.read<BlocCategory>().getList(),
                  loadChild: LoadShimmer(
                    isLoading: true,
                    child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                        height: 20,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemCount: 10,
                    ),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    itemBuilder: (context, index) => TextIcon(
                      onTap: () {
                        finish(context);
                        context.read<BlocNavHome>().changeTab(1);
                        context.read<BlocTabShop>().changeTab(index);
                      },
                      text: categories[index].name.validate().toUpperCase(),
                      expandedText: true,
                      edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                      textStyle: StyleApp.textStyle500(fontSize: 12),
                      suffix: const Icon(
                        Icons.keyboard_arrow_right,
                        color: ColorApp.grey4F,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0),
                    itemCount: categories.length,
                  ),
                );
              },
            ).expand(),
          ],
        ),
      ),
    );
  }
}
