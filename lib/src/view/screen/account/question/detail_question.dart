import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_question.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

class DetailQuestion extends StatelessWidget {
  ModelQuestion model;

  DetailQuestion({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Chi tiết câu hỏi",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Câu hỏi:",
              style: StyleApp.textStyle600(),
            ),
            5.height,
            Text(
              model.question.validate(),
              style: StyleApp.textStyle400(),
            ),
            10.height,
            Text(
              "Câu trả lời:",
              style: StyleApp.textStyle600(),
            ),
            Html(
              data: model.answer.validate(),
              style: {
                "body": Style(
                  // margin: EdgeInsets.zero,
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
