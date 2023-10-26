import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/select_index_cubit.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_address.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/address/sc_list_address.dart';
import 'package:thu_y_app/src/view/screen/address/widgets/item_address.dart';
import 'package:thu_y_app/src/view/screen/cart/widgets/layout.dart';
import 'package:thu_y_app/src/view/widget/item/dash.dart';

import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';

class BuildAddress extends StatelessWidget {
  Function(ModelAddress) onChange;
  BuildAddress({required this.onChange});
  ModelAddress? modelAddress;
  final indexBloc = SelectIndexCubit();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomListile(
          title: "Địa chỉ nhận hàng:",
          path: ImagePath.paymentLocation,
          titleButton: "Chỉnh sửa",
          onTap: () async {
            SCListAddress(
              checkChoice: true,
              modelAddress: modelAddress,
            ).nextPage(context).then((value) {
              if(value is ModelAddress){
                modelAddress = value;
                indexBloc.change(DateTime.now().millisecond);
                onChange(value);
              }
            });
          },
        ),
        const Dash(color: ColorApp.main).paddingSymmetric(horizontal: 10),
        const SizedBox(height: 15),
        BlocBuilder<SelectIndexCubit, int>(
          bloc: indexBloc,
          builder: (context, state) {
            if (modelAddress != null) {
              return ItemAddress(model: modelAddress!);
            }
            return Text(
              "Chưa chọn địa chỉ",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: StyleApp.textStyle400(color: ColorApp.blue1D),
            );
          },
        ).paddingSymmetric(horizontal: 10),
        const SizedBox(height: 20),
      ],
    );
  }
}
