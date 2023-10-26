
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../config/image_path.dart';
import '../../../../../config/style_app/init_style.dart';


class ItemNotificationOrder extends StatelessWidget {
  String title;
  String sub;
  String time;
  Function()? onTap;

   ItemNotificationOrder({
    required this.title,
    required this.sub,
    this.onTap,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorApp.main.withOpacity(0.3))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ImagePath.logo,
                  height: 55,
                  width: 55,
                ),
              ),
            ),
            const SizedBox(width:20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: StyleApp.textStyle600(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Html(data: sub.length > 100 ?  sub.substring(0,100) + "..." : sub,),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: ColorApp.grey4F,
                        size: 17,
                      ),
                      const SizedBox(width:5,),
                      Expanded(
                          child: Text(
                            time,
                            overflow: TextOverflow.ellipsis,
                            style: StyleApp.textStyle400(color:  ColorApp.grey4F),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
