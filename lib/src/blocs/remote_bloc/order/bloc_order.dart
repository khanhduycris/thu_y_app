import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_local.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import 'models/model_order.dart';
import 'param/order_param.dart';

List<ModelLocal> deliveryStatus = [
  ModelLocal(
    id: "pending",
    name: "Chờ xác nhận"
  ),
  ModelLocal(
      id: "confirmed",
      name: "Đã xác nhận"
  ),
  ModelLocal(
      id: "picked_up",
      name: "Chờ giao hàng"
  ),
  ModelLocal(
      id: "on_the_way",
      name: "Đang giao hàng"
  ),
  ModelLocal(
      id: "delivered",
      name: "Đã giao hàng"
  ),
  ModelLocal(
      id: "cancelled",
      name: "Đơn hàng hủy"
  ),
];

class BlocOrder extends Cubit<CubitState> {
  BlocOrder() : super(CubitState());
  List<ModelOrder> orders = [];

  //pending : Chờ xác nhận ;
  // confirmed : Đã xác nhận ;
  // picked_up : Đã lấy hàng ;
  // on_the_way : Đang đi giao ;
  // delivered : Đã giao hàng ;
  // cancelled : Đơn hàng hủy

  final param = OrderParam(
    page: 1,
    limit: 20,
    delivery_status: "pending",
  );

  getList() async {
    orders.clear();
    param.page = 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getOrder,
        req: param.toMap(),
      );

      for (var item in res['data']['data']) {
        ModelOrder order = ModelOrder.fromJson(item);
        orders.add(order);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy đơn hàng thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  onMore() async {
    param.page++;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getOrder,
        req: param.toMap(),
      );

      for (var item in res['data']['data']) {
        ModelOrder order = ModelOrder.fromJson(item);
        orders.add(order);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy đơn hàng thành công"));
    } catch (e) {
      param.page--;
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
