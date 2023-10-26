import 'package:flutter/material.dart';
import '../../../blocs/enum/bloc_status.dart';
import '../../../blocs/state/cubit_state.dart';
import '../../../config/style_app/init_style.dart';
import 'item_loadfail.dart';


Widget LoadPage({
  required CubitState state,
  Function()? reLoad,
  Widget? child,
  Widget? loadChild,
  String? message,
  double? height = 200,
}) {
  switch (state.status) {
    case BlocStatus.loading:
      return loadChild ??  SizedBox(
        height: height,
        child:  const Center(
          child: CircularProgressIndicator(color: ColorApp.main, strokeWidth: 2,),
        ),
      );
    case BlocStatus.success:
      return child ??
          const SizedBox(
            height: 10,
          );
    case BlocStatus.failure:
      return SizedBox(
        height: height,
        child: Center(
          child: ItemLoadFaild(
            message: message ?? state.msg,
            onPressed: reLoad,
          ),
        ),
      );
    default:
      return const SizedBox(
        height: 10,
      );
  }
}
