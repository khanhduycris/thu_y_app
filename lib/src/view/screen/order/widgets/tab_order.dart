import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/order/bloc_order.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/load/load_more_list.dart';
import 'package:thu_y_app/src/view/widget/load/loading_more.dart';

import 'item_order.dart';

class TabOrder extends StatelessWidget {
  BlocOrder bloc;

  TabOrder({required this.bloc});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        bloc.onMore();
      }
    });
    return BlocBuilder<BlocOrder, CubitState>(
      bloc: bloc,
      builder: (context, state) {
        return LoadingMore(
          state: state,
          reLoad: () => bloc.getList(),
          height: null,
          isMore: state.status == BlocStatus.loading && bloc.orders.isNotEmpty,
          child: bloc.orders.isEmpty
              ? Center(
                  child: Text(
                    "Danh sách trống",
                    style: StyleApp.textStyle400(),
                  ),
                )
              : SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ItemOrder(
                          modelOrder: bloc.orders[index],
                        ),
                        separatorBuilder: (context, index) => 10.height,
                        itemCount: bloc.orders.length,
                      ),
                      LoadMoreList(
                        isLoad: state.status == BlocStatus.loading &&
                            bloc.orders.isNotEmpty,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
