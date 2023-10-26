import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/select_index_cubit.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/models/model_banner.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/launch_url.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../blog/sc_list_blog.dart';

class HeaderHome extends StatefulWidget {
  List<ModelBanner> banners = [];

  HeaderHome({required this.banners});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  final indexBloc = SelectIndexCubit();

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AcctionWidget(),
        ],
      ).paddingSymmetric(vertical: 15);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CarouselSlider(
                  items: List.generate(
                    widget.banners.length,
                    (index) => ImageNetWorkView(
                      imageUrl: widget.banners[index].banner.validate(),
                      fit: BoxFit.fill,
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    height: 180,
                    onPageChanged: (index, reason) {
                      indexBloc.change(index);
                    },
                  ),
                ),
                47.height,
              ],
            ),
            Positioned(
              bottom: 0,
              child: AcctionWidget(),
            )
          ],
        ),
        16.height,
        BlocBuilder<SelectIndexCubit, int>(
          bloc: indexBloc,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.banners.length,
                (index) => Container(
                  width: 18.67,
                  height: 4.67,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: ShapeDecoration(
                    color: state == index
                        ? ColorApp.blue1D
                        : ColorApp.blue1D.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.67),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Container AcctionWidget() {
    return Container(
      width: 358,
      height: 75,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F93A7DB),
            blurRadius: 17,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          ItemAcction(
            imagePath: ImagePath.homeChat,
            title: "Tin nhắn",
            onTap: () {
            LaunchUrl.url("http://zaloapp.com/18x5yyaih58y6");
            },
          ).expand(),
          VerticalDivider(
            width: 0,
            color: ColorApp.blue1D.withOpacity(0.5),
          ).withHeight(40),
          ItemAcction(
            imagePath: ImagePath.homeSupport,
            title: "Gọi tư vấn",
            onTap: () {
              LaunchUrl.phone("0339604406");
            },
          ).expand(),
          VerticalDivider(
            width: 0,
            color: ColorApp.blue1D.withOpacity(0.5),
          ).withHeight(40),
          ItemAcction(
            imagePath: ImagePath.homeLibrary,
            title: "Thư viện",
          ).expand(),
          VerticalDivider(
            width: 0,
            color: ColorApp.blue1D.withOpacity(0.5),
          ).withHeight(40),
          ItemAcction(
            imagePath: ImagePath.homeNews,
            title: "Tin tức",
            onTap: () => ScListBlog().nextPage(context),
          ).expand(),
        ],
      ),
    );
  }
}

Widget ItemAcction({
  required String imagePath,
  required String title,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 27,
          ),
          5.height,
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: StyleApp.textStyle500(
              fontSize: 12,
              color: ColorApp.blue1D,
            ),
          ),
        ],
      ),
    ),
  );
}
