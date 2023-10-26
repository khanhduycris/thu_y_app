import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import 'models/model_address.dart';

class BlocListAddress extends Cubit<CubitState> {
  BlocListAddress() : super(CubitState());
  List<ModelAddress> list = [];

  getList() async {
    list.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.listAddress,
      );

      for (var item in res['data']) {
        ModelAddress modelAddress = ModelAddress.fromJson(item);
        list.add(modelAddress);
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Thành công.",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
