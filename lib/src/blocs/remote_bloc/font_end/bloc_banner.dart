import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/model_banner.dart';
import 'param/banner_param.dart';

class BlocBanner extends Cubit<CubitState> {
  BlocBanner() : super(CubitState());
  List<ModelBanner> banners = [];

  getBanner(BannerParam param) async {
    banners.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
          endPoint: "${ApiPath.banner}"
              "?position=${param.position ?? ""}"
              "&featured=${param.featured ?? ""}");
      for (var item in res['data']) {
        ModelBanner banner = ModelBanner.fromJson(item);
        banners.add(banner);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy banner thành công."));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
