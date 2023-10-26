import 'package:flutter/material.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';
import '../../../config/style_app/init_style.dart';

class ItemColumn extends StatelessWidget {
  String imagePath;
  String title;
  Color colorBgImage;
  Function()? onTap;
  bool hasCategory;

  ItemColumn({
    required this.imagePath,
    required this.title,
    this.colorBgImage = ColorApp.main,
    this.onTap,
    this.hasCategory = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          hasCategory
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    //color: colorBgImage,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ImageNetWorkView(
                        imageUrl: imagePath, fit: BoxFit.cover),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: colorBgImage,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: StyleApp.textStyle400(
              color: ColorApp.grey66,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
