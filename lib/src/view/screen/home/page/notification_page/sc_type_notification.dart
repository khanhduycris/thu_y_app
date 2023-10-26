import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/string_ext.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

import 'package:thu_y_app/src/view/screen/home/widgets/notification_widget/item_notification_order.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../../../../blocs/enum/bloc_status.dart';
import '../../../../../blocs/remote_bloc/notification/bloc_list_notifi.dart';
import '../../../../widget/load/load_more_list.dart';
import '../../../../widget/load/load_prd.dart';
import 'detail_notification.dart';

class ScreenTypenotification extends StatefulWidget {
  int type;

  ScreenTypenotification({required this.type});

  @override
  State<ScreenTypenotification> createState() => _ScreenTypenotificationState();
}

class _ScreenTypenotificationState extends State<ScreenTypenotification> {
  ScrollController scrollController = ScrollController();
  final bloc = BlocListNotifi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.param.type = widget.type;
    bloc.getList();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        bloc.onMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: widget.type == 2 ? "Thông báo hhuyến mãi" : "Thông báo sản phẩm",
      ),
      body: BlocBuilder<BlocListNotifi, CubitState>(
        bloc: bloc,
        builder: (context, state) {
          return LoadPage(
            state: state,
            reLoad: () => bloc.getList(),
            loadChild: LoadingCart(),
            child: bloc.list.isEmpty
                ? Center(
                    child: Text(
                      "Danh sách trống",
                      style: StyleApp.textStyle400(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ItemNotificationOrder(
                          title: bloc.list[index].title.validate(),
                          sub: bloc.list[index].short_content.validate(),
                          time: bloc.list[index].createdAt.formatDateString(),
                          onTap: () {
                            ScreenDetailnotification(notifi: bloc.list[index])
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
    );
  }
}
