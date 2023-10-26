import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/select_index_cubit.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_detail_prd.dart';
import 'package:thu_y_app/src/config/extension/string_ext.dart';

import '../../../../config/style_app/init_style.dart';

class OptionWidget extends StatefulWidget {
  ModelDetailPrd prd;
  Function(dynamic) option;

  OptionWidget({
    required this.prd,
    required this.option,
  });

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  Map<String, dynamic> data = {};

  final indexBloc = SelectIndexCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.prd.colors ?? []).isNotEmpty) {
      data["color"] = widget.prd.colors![0].title;
    }
    if ((widget.prd.choiceOptions ?? []).isNotEmpty) {
      for (var element in (widget.prd.choiceOptions ?? [])) {
        data[element.title] = element.options![0];
      }
    }
    widget.option(data);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectIndexCubit, int>(
      bloc: indexBloc,
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.prd.colors != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Divider(
                        height: 0,
                        color: ColorApp.greyF6,
                        thickness: 3,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Màu sắc",
                        style: StyleApp.textStyle600(),
                      ),
                      Wrap(
                        children: List.generate(
                          widget.prd.colors!.length,
                          (index) => InkWell(
                            onTap: () {
                              data["color"] = widget.prd.colors![index].title;
                              widget.option(data);
                              indexBloc.change(DateTime.now().millisecond);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 10, top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: data["color"] ==
                                              widget.prd.colors![index].title
                                          ? ColorApp.main
                                          : ColorApp.greyF2,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: widget.prd.colors![index].color
                                          .validate()
                                          .fromHex(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  5.width,
                                  Text(
                                    widget.prd.colors![index].title.validate(),
                                    style: StyleApp.textStyle400(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.prd.choiceOptions != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: List.generate(widget.prd.choiceOptions!.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.prd.choiceOptions![index].title ??
                                  "Chưa cập nhật",
                              style: StyleApp.textStyle600(),
                            ),
                            if (widget.prd.choiceOptions![index].options !=
                                null)
                              Wrap(
                                children: List.generate(
                                  widget.prd.choiceOptions![index].options!
                                      .length,
                                  (index1) => btnOption(
                                    item: widget.prd.choiceOptions![index]
                                        .options![index1],
                                    key: widget.prd.choiceOptions![index].title
                                        .validate(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  btnOption({
    required String item,
    required String key,
  }) {
    return InkWell(
      onTap: () {
        data[key] = item;
        widget.option(data);
        indexBloc.change(DateTime.now().millisecond);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(right: 10, top: 10),
        decoration: BoxDecoration(
            color: data[key] == item ? ColorApp.main : ColorApp.greyF6,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          item,
          style: StyleApp.textStyle400(
            color: data[key] == item ? Colors.white : ColorApp.black,
          ),
        ),
      ),
    );
  }
}
