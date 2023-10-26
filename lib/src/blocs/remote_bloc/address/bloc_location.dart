import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_local.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';

class BlocLocation extends Cubit<CubitState> {
  BlocLocation() : super(CubitState());

  List<ModelLocal> provinces = [];
  List<ModelLocal> districts = [];
  List<ModelLocal> wards = [];

  ModelLocal? province;
  ModelLocal? district;
  ModelLocal? ward;

  getProvince() async {
    provinces.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(endPoint: ApiPath.provinces);

      for (var item in res['data']) {
        ModelLocal model = ModelLocal.fromJson(item);
        provinces.add(model);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  getDistrict(String id) async {
    districts.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res =
          await Api.getAsync(endPoint: ApiPath.districts + id.toString());

      for (var item in res['data']) {
        ModelLocal model = ModelLocal.fromJson(item);
        districts.add(model);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  getWard(String id) async {
    wards.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(endPoint: ApiPath.wards + id.toString());

      for (var item in res['data']) {
        ModelLocal model = ModelLocal.fromJson(item);
        wards.add(model);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  setValue({ModelLocal? value}) {
    province = value;
    district = value;
    ward = value;
    emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
  }
}
