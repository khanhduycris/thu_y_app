
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_category.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_path.dart';
import '../../enum/bloc_status.dart';
List<ModelCategory> categories = [];
class BlocCategory extends Cubit<CubitState> {
  BlocCategory() : super(CubitState());

  List<ModelCategory> categoriesParent = [];

  getList() async {
    categories.clear();
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      var res = await Api.getAsync(endPoint: ApiPath.category);
      for(var item in res['data']){
        ModelCategory category = ModelCategory.fromJson(item);
        categories.add(category);
      }
      emit(state.copyWith(
          status: BlocStatus.success, msg: "Lấy danh mục thành công."));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
    }
  }

  // getParent(int id) async {
  //   categoriesParent.clear();
  //   emit(state.copyWith(status: BlocStatus.loading));
  //   try {
  //     var res = await Api.getAsync(endPoint: "${ApiPath.category}?parent_id=$id");
  //     for(var item in res['data']){
  //       ModelCategory category = ModelCategory.fromJson(item);
  //       categoriesParent.add(category);
  //     }
  //     emit(state.copyWith(
  //         status: BlocStatus.success, msg: "Lấy danh mục thành công."));
  //   } catch (e) {
  //     emit(state.copyWith(status: BlocStatus.failure, msg: Api.checkError(e)));
  //   }
  // }
}
