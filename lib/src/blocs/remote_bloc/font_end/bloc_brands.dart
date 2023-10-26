import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/model_brand.dart';

class BlocBrands extends Cubit<CubitState> {
  BlocBrands() : super(CubitState());
  List<Modelbrand> brands = [];

  getBrand() async {
    brands.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(endPoint: ApiPath.brands);

      for (var item in res['data']) {
        Modelbrand modelbrand = Modelbrand.fromJson(item);
        brands.add(modelbrand);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy thương hiệu thành công."));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

}
