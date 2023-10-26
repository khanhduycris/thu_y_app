import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/bool_cubit.dart';

import '../../../../config/style_app/init_style.dart';

class BuildDescription extends StatelessWidget {
  String title;
  String? description;

  BuildDescription({
    required this.title,
    this.description,
  });

  final boolBloc = BoolCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: BlocBuilder<BoolCubit, bool>(
        bloc: boolBloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                    color: ColorApp.greyF2,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  title.toUpperCase(),
                  style: StyleApp.textStyle700(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Html(
                data: description.validate(value: "Đang cập nhật").length >
                            1000 &&
                        !state
                    ? description
                        .validate(value: "Đang cập nhật")
                        .substring(0, 1000)
                    : description.validate(value: "Đang cập nhật"),
                style: {
                  "body": Style(
                    // margin: EdgeInsets.zero,
                  )
                },
              ),
              if (description.validate().length > 1000)
                TextButton(
                  onPressed: () {
                    boolBloc.change(!state);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state ? "Ẩn bớt" : "Xem thêm",
                        style: StyleApp.textStyle400(
                          color: ColorApp.blue03,
                          fontSize: 13,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_double_arrow_right,
                        color: ColorApp.blue03,
                        size: 13,
                      ),
                    ],
                  ),
                )
              else
                15.height,
            ],
          );
        },
      ),
    );
  }
}
