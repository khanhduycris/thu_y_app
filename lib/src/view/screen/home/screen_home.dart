import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/category/sc_category_drawer.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import 'package:thu_y_app/src/view/screen/home/page/account_page.dart';
import 'package:thu_y_app/src/view/screen/home/page/home_page.dart';
import 'package:thu_y_app/src/view/screen/home/page/notification_page/notification_page.dart';
import 'package:thu_y_app/src/view/screen/home/page/shop_page.dart';
import 'package:thu_y_app/src/view/screen/sc_form/sc_login.dart';

import 'widgets/nav_bottom.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocNavHome, int>(
      listener: (context, state) {
        _tabController.animateTo(state);
      },
      child: Scaffold(
        extendBody: true,
        drawer: ScCategoryDrawer(),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            ShopPage(),
            NotificationPage(),
            AccountPage(),
          ],
        ),
        bottomNavigationBar: NavBottom(
          centerOnTap: () {
            print("center");
          },
        ),
      ),
    );
  }
}
