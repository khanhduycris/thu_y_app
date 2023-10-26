import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/model_coupon.dart';

class BlocCoupon extends Cubit<CubitState> {
  BlocCoupon() : super(CubitState());
  List<ModelCoupon> list = [];

  getList() async {
    list.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(endPoint: ApiPath.coupon);
      for (var item in res['data']) {
        ModelCoupon coupon = ModelCoupon.fromJson(item);
        list.add(coupon);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
