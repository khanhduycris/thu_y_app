import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';

import '../../../../blocs/enum/bloc_status.dart';

class BlocDetailScreen extends Cubit<CubitState> {
  BlocDetailScreen() : super(CubitState());

  int count = 1;
  String? variant;

  updateCount({
    bool isTang = false,
    int? countMax,
    int? countMin,
  }) {
    if (countMin != null && isTang) {
      count = countMin;
    }
    if (isTang && countMin == null) {
      if (countMax == null) {
        count++;
      } else {
        if (count < countMax) {
          count++;
        } else {
          count = countMax;
        }
      }
    } else {
      if (countMin == null) {
        if (count > 1) {
          count--;
        }
      } else {
        if (count > countMin) {
          count--;
        } else {
          count = countMin;
        }
      }
    }
    emit(state.copyWith(status: BlocStatus.success));
  }

  getVariant(Map<String, dynamic> option){
    option.forEach((key, value) {
      variant = "${variant.validate()}$value-";
    });
  }
}
