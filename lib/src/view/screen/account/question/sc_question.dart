import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/screen/account/question/detail_question.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_more_list.dart';
import 'package:thu_y_app/src/view/widget/load/loading_more.dart';

import '../../../../blocs/remote_bloc/font_end/bloc_question.dart';

class ScreenQuestion extends StatefulWidget {
  const ScreenQuestion({super.key});

  @override
  State<ScreenQuestion> createState() => _ScreenQuestionState();
}

class _ScreenQuestionState extends State<ScreenQuestion> {
  final bloc = BlocQuestion();
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getList();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        bloc.onMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Câu hỏi thường gặp"),
      body: BlocBuilder<BlocQuestion, CubitState>(
        bloc: bloc,
        builder: (context, state) {
          return LoadingMore(
            height: null,
            state: state,
            reLoad: () => bloc.getList(),
            isMore: bloc.list.isNotEmpty && state.status == BlocStatus.loading,
            child: SingleChildScrollView(
              controller: controller,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => DetailQuestion(model: bloc.list[index]).nextPage(context),
                      child: Text(
                        bloc.list[index].question.validate(),
                        style: StyleApp.textStyle400(),
                      ).paddingSymmetric(vertical: 10),
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0),
                    itemCount: bloc.list.length,
                  ),
                  LoadMoreList(
                      isLoad: bloc.list.isNotEmpty &&
                          state.status == BlocStatus.loading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
