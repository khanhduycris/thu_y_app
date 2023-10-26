import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

class ItemTitle extends StatelessWidget {
  Function()? onTap;
  String title;
  double sizeImage;
  double fontSize;
  ItemTitle({
    this.onTap,
    required this.title,
    this.fontSize = 14,
    this.sizeImage = 13,
  });
  @override
  Widget build(BuildContext context) {
    return TextIcon(
      expandedText: true,
      edgeInsets: const EdgeInsets.symmetric(horizontal: 10),
      prefix: Image.asset(
        ImagePath.chanMeo,
        height: sizeImage,
        width: sizeImage,
      ),
      text: title,
      textStyle: StyleApp.textStyle700(
        color: ColorApp.blue1D,
        fontSize: fontSize,
      ),
      suffix: onTap == null
          ? null
          : TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "Xem thêm",
                style: StyleApp.textStyle400(
                  color: ColorApp.blue0D,
                  fontSize: 12,
                ),
              ),
            ),
    ).withHeight(20);
  }
}
