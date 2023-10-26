import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

class ItemBankingOption extends StatelessWidget {
  String? imageUrl;
  String? nameBank;
  String? nameMaster;
  String? location;
  String? number;


  ItemBankingOption({
    this.imageUrl,
    this.nameBank,
    this.nameMaster,
    this.location,
    this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageNetWorkView(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
        ).expand(flex: 3),
        10.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(nameBank!,style: StyleApp.textStyle500()),
            5.height,
            Text("Chủ tài khoản: ${nameMaster!}",style: StyleApp.textStyle400()),
            5.height,
            Text("Chi nhánh: ${location!}",style: StyleApp.textStyle400()),
            5.height,
            Text("Số TK: ${number!}",style: StyleApp.textStyle400()),
          ],
        ).expand(flex: 10),
        const Icon(Icons.copy_all_outlined,color: ColorApp.main,size: 22,).expand(flex: 1).onTap((){
              Clipboard.setData(ClipboardData(text: "$number"));
              toast("Copy thành công");
        })
      ],
    ).paddingSymmetric(horizontal: 10,vertical: 10);
  }
}
