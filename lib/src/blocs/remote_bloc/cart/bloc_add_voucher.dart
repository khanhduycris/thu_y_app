import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';

class BlocAddVoucher extends Cubit<CubitState> {
  BlocAddVoucher() : super(CubitState());

  addVoucher(String code) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.postAsync(
        endPoint: ApiPath.addVoucherPay,
        req: {"coupon_code": code},
      );
      if (res['result'] == true) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            msg: "Thêm Voucher thành công",
            data: code,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Thêm Voucher thất bại",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
