import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_new.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

import '../../../config/style_app/init_style.dart';
import '../../widget/item/image_network_view.dart';

class ScDetailBlog extends StatelessWidget {
  ModelNew model;

  ScDetailBlog({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Chi tiết tin tức"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageNetWorkView(
              imageUrl: model.banner.toString(),
              height: 356,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Text(
              model.title?.toUpperCase() ?? "Đang cập nhât",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: StyleApp.textStyle700(fontSize: 16),
            ).paddingSymmetric(horizontal: 10),
            const SizedBox(
              height: 10,
            ),
            Html(
              data: model.description ?? "Chưa cập nhật",
              style: {
                "body": Style(
                  // margin:  EdgeInsets.symmetric(horizontal: 10),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
