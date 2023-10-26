
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/notification/param/notification_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/model_notifi.dart';

class BlocListNotifi extends Cubit<CubitState> {
  BlocListNotifi() : super(CubitState());
  List<ModelNotifi> list = [];

  //1 : Thông báo sản phẩm ; 2 : Thông báo chương trình khuyến mại; 3 : Thông báo tin tức mới
  final param = NotificationParam(
    page: 1,
    limit: 20,
    type: 1,
  );

  getList() async {
    list.clear();
    param.page = 1;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getNotifi,
        req: param.toMap(),
      );

      for (var item in res['data']) {
        ModelNotifi order = ModelNotifi.fromJson(item);
        list.add(order);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  onMore() async {
    param.page++;
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(
        endPoint: ApiPath.getNotifi,
        req: param.toMap(),
      );

      for (var item in res['data']) {
        ModelNotifi order = ModelNotifi.fromJson(item);
        list.add(order);
      }
      emit(state.copyWith(status: BlocStatus.success, msg: "Thành công"));
    } catch (e) {
      param.page--;
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
