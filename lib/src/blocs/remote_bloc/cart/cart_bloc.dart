import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'param/add_cart_param.dart';

class BlocCart extends Cubit<CubitState> {
  BlocCart() : super(CubitState());

  addCart(AddCartParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try{
      final res = await Api.postAsync(endPoint: ApiPath.addCart, req: param.toMap());
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Thêm sản phẩm vào giỏ hàng thành công.",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Thêm sản phẩm vào giỏ hàng thất bại.",
          ),
        );
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy thông tin giỏ hàng thành công.",
        ),
      );
    }catch(e){
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  updateQty(AddCartParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.changeQuantity,
        req: param.toMap(),
      );
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Cập nhật số lượng thành công.",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Cập nhật số lượng thất bại.",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  removeCart(int id) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.deleteAsync(
        endPoint: ApiPath.deteleItemCart + id.toString(),
       isToken: true,
      );
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Xóa sản phẩm thành công.",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Xóa sản phẩm thất bại.",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  addAddressCart(int id) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.applyAddress,
       isToken: true,
        req: {
          "address_id":id
        }
      );
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Cập nhật địa chỉ nhận hàng thành công.",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Cập nhật địa chỉ nhận hàng thất bại.",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }


}
