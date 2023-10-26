import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

import '../../../blocs/remote_bloc/order/bloc_order.dart';
import 'widgets/tab_order.dart';

class ScreenOrder extends StatefulWidget {
  int page;

  ScreenOrder({this.page = 0});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final blocOrder = BlocOrder();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: deliveryStatus.length, vsync: this);
    _tabController.animateTo(widget.page);
    reload();
  }

  reload() {
    blocOrder.param.delivery_status = deliveryStatus[widget.page].id.validate();
    blocOrder.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Đơn hàng",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelStyle: StyleApp.textStyle400(),
            unselectedLabelStyle: StyleApp.textStyle400(),
            labelColor: ColorApp.main,
            unselectedLabelColor: ColorApp.black,
            indicatorColor: ColorApp.main,
            onTap: (value) {
              widget.page = value;
              reload();
            },
            tabs: List.generate(
              deliveryStatus.length,
              (index) => Tab(
                text: deliveryStatus[index].name.validate(),
              ),
            ),
          ).withHeight(35),
          TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              deliveryStatus.length,
              (index) => TabOrder(
                bloc: blocOrder,
              ),
            ),
          ).expand(),
        ],
      ),
    );
  }
}
