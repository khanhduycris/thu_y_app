import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/string_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/screen/home/page/notification_page/detail_notification.dart';
import 'package:thu_y_app/src/view/screen/home/page/notification_page/sc_type_notification.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/notification_widget/item_notification_order.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/notification_widget/item_type_notification.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_more_list.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';
import 'package:thu_y_app/src/view/widget/load/load_prd.dart';

import '../../../../../blocs/remote_bloc/notification/bloc_list_notifi.dart';
import '../../../../../config/style_app/init_style.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();

  final bloc = BlocListNotifi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        bloc.onMore();
      }
    });
  }

  Future<void> onRefresh() async {
    bloc.param.type = 3;
    bloc.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Thông báo",
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ItemtypeNotification(
                title: "Khuyến mãi",
                url: ImagePath.chanMeo,
                sub: "Danh sách khuyến mãi",
                onTap: () {
                  ScreenTypenotification(
                    type: 2,
                  ).launch(context);
                },
              ),
              ItemtypeNotification(
                title: "Thông báo sản phẩm",
                url: ImagePath.logo,
                sub: "Sản phẩm",
                onTap: () {
                  ScreenTypenotification(
                    type: 1,
                  ).launch(context);
                },
              ),
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: ColorApp.main.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Tin tức mới",
                  overflow: TextOverflow.ellipsis,
                  style: StyleApp.textStyle600(
                      fontSize: 16, color: ColorApp.black),
                ),
              ),
              BlocBuilder<BlocListNotifi, CubitState>(
                bloc: bloc,
                builder: (context, state) {
                  return LoadPage(
                    state: state,
                    reLoad: () => bloc.getList(),
                    loadChild: LoadingCart(isList: false).paddingTop(10),
                    child: bloc.list.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "Danh sách trống",
                                style: StyleApp.textStyle400(),
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    ItemNotificationOrder(
                                  title: bloc.list[index].title.validate(),
                                  sub:
                                      bloc.list[index].short_content.validate(),
                                  time: bloc.list[index].createdAt
                                      .formatDateString(),
                                  onTap: () {
                                    ScreenDetailnotification(
                                            notifi: bloc.list[index])
                                        .launch(context);
                                  },
                                ),
                                separatorBuilder: (context, index) => 10.height,
                                itemCount: bloc.list.length,
                              ),
                              LoadMoreList(
                                  isLoad: state.status == BlocStatus.loading &&
                                      bloc.list.isNotEmpty),
                            ],
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
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

List<ItemNotificationOrder> listFake = [
  ItemNotificationOrder(
      title: "Ra mắt sản phẩm tháng 6",
      sub: "A biggest discount in this year is Coming",
      time: "00:20 - 05/31/2023"),
  ItemNotificationOrder(
      title: "Ra mắt sản phẩm tháng 6",
      sub: "A biggest discount in this year is Coming",
      time: "00:20 - 05/31/2023"),
  ItemNotificationOrder(
      title: "Ra mắt sản phẩm tháng 6",
      sub: "A biggest discount in this year is Coming",
      time: "00:20 - 05/31/2023"),
  ItemNotificationOrder(
      title: "Ra mắt sản phẩm tháng 6",
      sub: "A biggest discount in this year is Coming",
      time: "00:20 - 05/31/2023"),
  ItemNotificationOrder(
      title: "Ra mắt sản phẩm tháng 6",
      sub: "A biggest discount in this year is Coming",
      time: "00:20 - 05/31/2023")
];
