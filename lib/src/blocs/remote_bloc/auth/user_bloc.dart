import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/change_pass_param.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/auth/param/login_param.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/api/api.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';

import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
import 'models/user_model.dart';
import 'param/sign_param.dart';
import 'param/update_user_param.dart';

class UserBloc extends Cubit<CubitState> {
  UserBloc() : super(CubitState());
  UserModel? userModel;

  sign(SignParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.postAsync(
        endPoint: ApiPath.signup,
        req: param.toMap(),
      );
      if (res['result']) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Đăng ký tài khoản thành công."));
      } else {
        emit(state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Đăng ký tài khoản không thành công"));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  login(LoginParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.postAsync(
        endPoint: ApiPath.login,
        req: param.toMap()
        // req: {
        //   "email" : param.phone,
        //   "password" : param.pass,
        //   "token_device" : param.token_device
        // },
      );
      if (res['result']) {
        // userModel = UserModel.fromJson(res['user']);
        // await setValue(DbKeysLocal.user, res['user']);
        // await setValue(DbKeysLocal.userId, userModel?.id);
        // await setValue(DbKeysLocal.accessToken, res['access_token']);
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Đăng nhập thành công."));
      } else {
        emit(state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ??
                "Đăng nhập thất bại. Tài khoản hoặc mật khẩu không chính xác."));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  removeUser() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.postAsync(
        endPoint: ApiPath.removeUser,
        req: {},
        isToken: true,
      );
      await DbKeysLocal.remover();
      if (res['result']) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Xóa tài khoản thành công."));
      } else {
        emit(state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Xóa tài khoản không thành công."));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  logOut() async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      await DbKeysLocal.remover();
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Đăng xuất thành công."));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  changePass(ChangePassParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      Map<String, dynamic> res = {
        "result": false,
      };
      if (param.phone != null) {
         res = await Api.postAsync(
          endPoint: ApiPath.chagePass,
          req: param.toMap(),
        );
      } else {
        res = await Api.postAsync(
          endPoint: ApiPath.changePassIsLogin,
          req: param.toMap(),
          isToken: true,
        );
      }

      if (res['result'] == true) {
        emit(state.copyWith(
            status: BlocStatus.success, msg: "Đổi mật khẩu thành công."));
      } else {
        emit(state.copyWith(
            status: BlocStatus.failure,
            msg: res['message'] ?? "Đổi mật khẩu thất bại."));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  getUser() async {
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

  updateUser(UpdateUserParam param) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.postAsync(
        endPoint: ApiPath.updateUser,
        req: param.toMap(),
        isToken: true,
      );
      var user = await Api.postAsync(
        endPoint: ApiPath.getProfile,
        req: {},
        isToken: true,
      );
      print(user);
      if (user['result']) {
        userModel = UserModel.fromJson(user);
        await setValue(DbKeysLocal.user, user);
      }
      // if (res['status'] == "true") {
      //   if (userModel != null) {
      //     userModel!.name = param.name;
      //     userModel!.email = param.email;
      //     userModel!.birthday = param.birthday;
      //     userModel!.gender = param.gender;
      //     print(userModel?.toJson());
      //     await setValue(DbKeysLocal.user, userModel?.toJson());
      //   }
      //   emit(state.copyWith(
      //       status: BlocStatus.success, msg: "Cập nhật thông tin thành công."));
      // } else {
      //   emit(state.copyWith(
      //       status: BlocStatus.failure,
      //       msg: res['message'] ?? "Cập nhật thông tin thất bại"));
      // }
      emit(
        state.copyWith(
          status: BlocStatus.failure,
          msg: res['message'] ?? "Cập nhật thông tin thất bại",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }
}
