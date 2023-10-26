
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';import 'models/model_prd.dart';
import 'param/page_limit_param.dart';

class BlocPrdFlashDeal extends Cubit<CubitState> {
  BlocPrdFlashDeal() : super(CubitState());
  List<ModelPrd> prds = [];
  final param = PageLimitParam(
    limit: 21,
    page: 1,
  );

  getList() async {
    prds.clear();
    param.page = 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.prdFlashSale,
        req: param.toMap(),
      );
      for (var item in res['data']) {
        ModelPrd prd = ModelPrd.fromJson(item);
        prds.add(prd);
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy sản phẩm thành công.",
          total: res['meta']['total'] ?? 0,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  onMore() async {
    param.page = param.page.validate() + 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final res = await Api.getAsync(
        endPoint: ApiPath.prdFlashSale,
        req: param.toMap(),
      );

      for (var item in res['data']) {
        ModelPrd prd = ModelPrd.fromJson(item);
        prds.add(prd);
      }
      emit(
        state.copyWith(
          status: BlocStatus.success,
          msg: "Lấy sản phẩm thành công.",
          total: res['meta']['total'] ?? 0,
        ),
      );
    } catch (e) {
      param.page = param.page.validate() - 1;
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
