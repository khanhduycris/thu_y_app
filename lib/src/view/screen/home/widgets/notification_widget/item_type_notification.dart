import 'package:flutter/material.dart';

import '../../../../../config/style_app/color_app.dart';
import '../../../../../config/style_app/init_style.dart';

class ItemtypeNotification extends StatelessWidget {
  String title;
  String sub;
  String url;
  int? count;
  Function()? onTap;

  ItemtypeNotification({
    required this.title,
    required this.url,
    required this.sub,
    this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: ColorApp.greyBD, width: 1))),
        child: Row(
          children: [
            Container(
                height: 55,
                width: 55,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(55),
                    border: Border.all(
                        color: ColorApp.main.withOpacity(0.2), width: 1)),
                child: Image.asset(url)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: StyleApp.textStyle600(
                        color: ColorApp.black, fontSize: 16),
                  ),
                  Text(
                    sub,
                    overflow: TextOverflow.ellipsis,
                    style: StyleApp.textStyle400(
                      color: ColorApp.grey82,
                    ),
                  ),
                ],
              ),
            ),
            count != null && count! > 0
                ? Container(
                    height: 21,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: ColorApp.blue1D,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "$count",
                          textAlign: TextAlign.center,
                          style: StyleApp.textStyle400(color: Colors.white),
                        ),
                        count != null && count! > 99
                            ? const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              )
                            : Container()
                      ],
                    ))
                : Container(),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.navigate_next,
              color: ColorApp.grey82,
            ),
          ],
        ),
      ),
    );
  }
}
