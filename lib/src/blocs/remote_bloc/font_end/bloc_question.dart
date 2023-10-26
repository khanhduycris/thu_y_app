import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/param/page_limit_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import 'models/model_question.dart';

class BlocQuestion extends Cubit<CubitState> {
  BlocQuestion() : super(CubitState());

  List<ModelQuestion> list = [];
  final paran = PageLimitParam(
    page: 1,
    limit: 20,
  );

  getList() async {
    list.clear();
    paran.page = 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.getQuestion,
        req: paran.toMap(),
      );
      for (var item in res['data']) {
        ModelQuestion model = ModelQuestion.fromJson(item);
        list.add(model);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  onMore() async {
    paran.page++;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.getQuestion,
        req: paran.toMap(),
      );
      for (var item in res['data']) {
        ModelQuestion model = ModelQuestion.fromJson(item);
        list.add(model);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      paran.page--;
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
