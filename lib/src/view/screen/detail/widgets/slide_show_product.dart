import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';

import '../../../../config/style_app/init_style.dart';

class SlideShow extends StatefulWidget {
  List list;

  SlideShow({required this.list});

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return Image.asset(
        ImagePath.defaultImage,
        height: 280,
        fit: BoxFit.cover,
      );
    }
    if (widget.list.length == 1) {
      return ImageNetWorkView(
        imageUrl: widget.list[0],
        width: double.infinity,
        height: 380,
        fit: BoxFit.cover,
      );
    }
    return Stack(
      children: [
        CarouselSlider(
          items: List.generate(
            widget.list.length,
            (index) => ImageNetWorkView(
                imageUrl: widget.list[index],
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover),
          ),
          options: CarouselOptions(
              autoPlay: true,
              height: 380,
              viewportFraction: 1,
              onPageChanged: (val, a) {
                page = val + 1;
                setState(() {});
              }),
        ),
        Positioned(
          bottom: 40,
          right: 10,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$page/${widget.list.length}",
                style: StyleApp.textStyle400(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
