import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';

class BlocPayment extends Cubit<CubitState> {
  BlocPayment() : super(CubitState());

  payment() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.createOrder,
        req: {
          "payment_type": "cod_payment"
        }
      );
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Thanh toán đơn hàng thành công.",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Thanh toán đơn hàng thất bại.",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
