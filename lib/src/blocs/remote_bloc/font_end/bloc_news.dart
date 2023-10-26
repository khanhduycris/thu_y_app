import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/param/page_limit_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import 'models/model_new.dart';

class BlocNews extends Cubit<CubitState> {
  BlocNews() : super(CubitState());
  List<ModelNew> news = [];

  final param = PageLimitParam(page: 1, limit: 20);

  getList() async {
    news.clear();
    param.page = 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getNews,
        req: param.toMap(),
      );

      for (var item in res['data']) {
        ModelNew model = ModelNew.fromJson(item);
        news.add(model);
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy tin tức thành công.",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  onMore() async {
    param.page++;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getNews,
        req: param.toMap(),
      );

      for (var item in res['data']) {
        ModelNew model = ModelNew.fromJson(item);
        news.add(model);
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy tin tức thành công.",
        ),
      );
    } catch (e) {
      param.page--;
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

}
