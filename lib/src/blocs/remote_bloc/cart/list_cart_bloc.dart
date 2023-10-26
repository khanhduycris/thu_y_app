import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/models/model_cart.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';

class BlocListCart extends Cubit<CubitState> {
  BlocListCart() : super(CubitState());
  List<ModelCart> carts = [];

  int totalPrice = 0;

  getList() async {
    carts.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.listCart,
        req: {},
      );
      for (var item in res) {
        if (item['product_gift_id'] == 0) {
          ModelCart cart = ModelCart.fromJson(item);
          carts.add(cart);
        }
      }
      getPrice();
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy thông tin giỏ hàng thành công.",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  reLoad() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.listCart,
        req: {},
      );
      carts.clear();
      for (var item in res) {
        if (item['product_gift_id'] == 0) {
          ModelCart cart = ModelCart.fromJson(item);
          carts.add(cart);
        }
      }
      getPrice();
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy thông tin giỏ hàng thành công.",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  remove(ModelCart item) async {
    carts.remove(item);
    getPrice();
    emit(
      state.copyWith(
        status: BlocStatus.success,
        msg: "Lấy thông tin giỏ hàng thành công.",
      ),
    );
  }

  getPrice() {
    totalPrice = 0;
    for (var element in carts) {
      totalPrice += (element.price.validate() * element.quantity.validate());
    }
  }
}
