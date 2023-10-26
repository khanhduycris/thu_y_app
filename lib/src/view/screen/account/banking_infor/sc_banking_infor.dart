import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/screen/account/banking_infor/widget/item_bank_option.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';

import '../../../../config/style_app/init_style.dart';

class ScreenbankingInfor extends StatefulWidget {
  const ScreenbankingInfor({super.key});

  @override
  State<ScreenbankingInfor> createState() => _ScreenbankingInforState();
}

class _ScreenbankingInforState extends State<ScreenbankingInfor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBarCustom(title: "Thông tin chuyển khoản"),
     body: Column(
       children: [
         Image.asset(ImagePath.logo,width: 100,).paddingSymmetric(vertical: 15),
         Container(
           color: ColorApp.bg,
           width: MediaQuery.of(context).size.width,
           padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
           child: Column(
             children: [
               Text("Quý khách hàng vui lòng chuyển khoản theo nội dung sau:",
                 style: StyleApp.textStyle400(),textAlign: TextAlign.center,),
               10.height,
               Text("Đức Tâm <Dấu cách> Mã đơn",style: StyleApp.textStyle500(color: ColorApp.main),)
             ],
           ),
         ),
         10.height,
         ListView.separated(
             shrinkWrap: true,
             physics:const NeverScrollableScrollPhysics(),
             itemBuilder: (context, index) => ItemBankingOption(
               imageUrl: listFake[index].imageUrl,
               nameBank: listFake[index].nameBank,
               nameMaster: listFake[index].nameMaster,
               location: listFake[index].location,
               number: listFake[index].number,
             ),
             separatorBuilder: (context, index) => const Divider(color: ColorApp.black33,),
             itemCount: listFake.length)
       ],
     ),
    );
  }
}
List<ItemBankingOption> listFake = [
  ItemBankingOption(
      imageUrl: "https://cdn.tgdd.vn/2020/03/GameApp/image(14)-200x200-1.png",
      nameBank: "BIDV",
      nameMaster: "nguyen thi thuy".toUpperCase(),
      location: "thái nguyên".toUpperCase(),
      number: "1122334455",
  ),
  ItemBankingOption(
    imageUrl: "https://cdn.tgdd.vn/2020/03/GameApp/image(14)-200x200-1.png",
    nameBank: "BIDV",
    nameMaster: "nguyen thi thuy".toUpperCase(),
    location: "thái nguyên".toUpperCase(),
    number: "1122334455",
  ),
  ItemBankingOption(
    imageUrl: "https://cdn.tgdd.vn/2020/03/GameApp/image(14)-200x200-1.png",
    nameBank: "BIDV",
    nameMaster: "nguyen thi thuy".toUpperCase(),
    location: "thái nguyên".toUpperCase(),
    number: "1122334455",
  ),
];