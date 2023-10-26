import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thu_y_app/src/config/extension/date_time_ext.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/blog/sc_detail_blog.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../blocs/remote_bloc/font_end/models/model_new.dart';
import '../../../../config/image_path.dart';
import '../../../../config/style_app/init_style.dart';

class ItemBlog extends StatefulWidget {
  ModelNew modelNew;

  ItemBlog({required this.modelNew});

  @override
  State<ItemBlog> createState() => _ItemBlogState();
}

class _ItemBlogState extends State<ItemBlog> {
  int? maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ScDetailBlog(model: widget.modelNew).nextPage(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuildHeaderNew(),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageNetWorkView(
              imageUrl: widget.modelNew.banner.toString(),
              height: 356,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.modelNew.title?.toUpperCase() ?? "Đang cập nhât",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: StyleApp.textStyle700(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.modelNew.shortDescription ?? "Đang cập nhât",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: StyleApp.textStyle400(),
          ),
        ],
      ),
    );
  }

  Row BuildHeaderNew() {
    DateTime time = DateTime.parse(widget.modelNew.createdAt.toString());
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            ImagePath.logo,
            fit: BoxFit.contain,
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Nava",
                    overflow: TextOverflow.ellipsis,
                    style: StyleApp.textStyle700(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Share.share(widget.modelNew.link ?? "");
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.share_outlined,
                        color: ColorApp.main,
                      ),
                      Text(
                        "Chia sẻ",
                        style: StyleApp.textStyle400(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              time.formatDataAgo,
              overflow: TextOverflow.ellipsis,
              style:
                  StyleApp.textStyle400(color: ColorApp.grey66, fontSize: 12),
            ),
          ]),
        )
      ],
    );
  }
}
