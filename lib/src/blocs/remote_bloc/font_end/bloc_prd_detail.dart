import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/model_detail_prd.dart';

class BlocPrdDetail extends Cubit<CubitState> {
  BlocPrdDetail() : super(CubitState());
  ModelDetailPrd? prd;

  getDetai(int id) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res =
          await Api.getAsync(endPoint: ApiPath.detailPrd  + id.toString());
      if (res['data'] is List) {
        prd = ModelDetailPrd.fromJson(res['data'][0]);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy chi tiết sản phẩm thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
