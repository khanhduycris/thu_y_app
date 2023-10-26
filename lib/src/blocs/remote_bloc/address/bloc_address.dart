import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/param/create_address_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';

class BlocAddress extends Cubit<CubitState> {
  BlocAddress() : super(CubitState());

  create(CreateAddressParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
          endPoint: ApiPath.createAddress, req: param.toMap());

      if (res['result'] == true) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Tạo địa chỉ thành công"));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          msg: res['message'] ?? "Tạo địa chỉ nhận hàng thất bại",
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  update(CreateAddressParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
          endPoint: ApiPath.updateAddress, req: param.toMap());

      if (res['result'] == true) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Cập nhật địa chỉ thành công"));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          msg: res['message'] ?? "Cập nhật địa chỉ nhận hàng thất bại",
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  setDefault(int id) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res =
          await Api.postAsync(endPoint: ApiPath.makeDefault, req: {"id": id});

      if (res['result'] == true) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Cập nhật địa chỉ thành công"));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          msg: res['message'] ?? "Cập nhật địa chỉ nhận hàng thất bại",
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
  remove(int id) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res =
          await Api.getAsync(endPoint: ApiPath.deleteAddress + id.toString(),isToken: true);

      if (res['result'] == true) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Xóa địa chỉ thành công"));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          msg: res['message'] ?? "Xóa địa chỉ nhận hàng thất bại",
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
