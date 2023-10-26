import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';

class ScreenShare extends StatelessWidget {
  const ScreenShare({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorApp.main,
      appBar: AppBarCustom(title: "Chia sẻ bạn bè"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Link chia sẻ của bạn",style: StyleApp.textStyle700(fontSize: 20,color: Colors.white),),
          20.height,
          Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Text("https://chamsocvatnuoi.com//linkshare",
                style: StyleApp.textStyle400(),overflow: TextOverflow.ellipsis),
          ),
          30.height,
          Center(
            child: CustomButton(
                title: "Share link",
                textColor: Colors.white,
                borderSide: const BorderSide(color: Colors.white,width: 1.5),
                onTap: () {},
            ),
          )
        ],
      ).paddingSymmetric(vertical: 30,horizontal: 15),
    );
  }
}
