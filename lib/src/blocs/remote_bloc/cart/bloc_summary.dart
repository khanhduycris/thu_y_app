import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/models/model_summary.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';

class BlocSummary extends Cubit<CubitState> {
  BlocSummary() : super(CubitState());
  ModelSummary? summary;

  getData() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.getAllCart,
      );
      if (res != null) {
        summary = ModelSummary.fromJson(res ?? {});
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy thông tin thành công.",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
