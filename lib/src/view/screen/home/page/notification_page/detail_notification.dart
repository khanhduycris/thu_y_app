import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/notification/models/model_notifi.dart';
import 'package:thu_y_app/src/view/screen/home/widgets/notification_widget/item_notification_order.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

class ScreenDetailnotification extends StatelessWidget {
  ModelNotifi notifi;

  ScreenDetailnotification({required this.notifi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: notifi.title.validate()),
      body: Html(
        data: notifi.content.validate(),
      ),
    );
  }
}
