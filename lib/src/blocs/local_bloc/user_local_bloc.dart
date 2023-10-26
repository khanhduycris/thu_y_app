import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';

import '../../config/api/api.dart';
import '../../config/api/api_path.dart';
import '../enum/bloc_status.dart';
import '../remote_bloc/auth/models/user_model.dart';

class UserLocalBloc extends Cubit<CubitState> {
  UserLocalBloc() : super(CubitState());
  UserModel? userModel;

  getUser() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = getJSONAsync(DbKeysLocal.user);
      userModel = UserModel.fromJson(res);
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy thông tin thành công."));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: e.toString()));
    }
  }

  getUserRemote() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.postAsync(
        endPoint: ApiPath.getProfile,
        req: {},
        isToken: true,
      );
      if (res['result']) {
        userModel = UserModel.fromJson(res);
        await setValue(DbKeysLocal.user, res);
        emit(state.copyWith(
            status: BlocStatus.success,
            msg: "Lấy thông tin tài khoản thành công."));
      } else {
        emit(state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Lấy thông tin tài khoản thất bại"));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
