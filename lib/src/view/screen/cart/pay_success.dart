import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import 'package:thu_y_app/src/view/screen/home/screen_home.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import '../../../config/image_path.dart';
import '../../../config/style_app/init_style.dart';

class PaySuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logo,
              alignment: Alignment.center,
              width: 100,
              cacheWidth: 100,
            ),
            10.height,
            Text(
              "Đặt hàng thành công",
              style: StyleApp.textStyle700(),
            ),
            Text(
              "Quay lại trang chủ và tiếp tục mua sắm nào",
              style: StyleApp.textStyle700(),
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: "Về trang chủ",
              onTap: () {
                context.read<BlocNavHome>().changeTab(0);
                context.read<BlocListCart>().getList();
                ScreenHome().nextPage(context, isNewTask: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
