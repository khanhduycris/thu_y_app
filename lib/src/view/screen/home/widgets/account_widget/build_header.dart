import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../../config/style_app/init_style.dart';

class BuildHeaderAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocalBloc, CubitState>(
      builder: (context, state) {
        final userModel = context.read<UserLocalBloc>().userModel;
        return Container(
          height: 75,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  ImagePath.logo,
                  height: 75,
                  width: 75,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userModel?.name ?? "Tên chưa cung cấp",
                      style: StyleApp.textStyle700(
                        color: ColorApp.main,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    3.height,
                    TextIcon(
                      expandedText: true,
                      edgeInsets: EdgeInsets.zero,
                      prefix: const Icon(
                        CupertinoIcons.phone,
                        color: ColorApp.grey66,
                        size: 17,
                      ),
                      text: userModel?.phone ?? "Chưa cập nhật",
                      textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                    ),
                    TextIcon(
                      expandedText: true,
                      edgeInsets: EdgeInsets.zero,
                      prefix: const Icon(
                        CupertinoIcons.mail,
                        color: ColorApp.grey66,
                        size: 17,
                      ),
                      text: userModel?.email ?? "Chưa cập nhật",
                      textStyle: StyleApp.textStyle400(color: ColorApp.grey66),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
