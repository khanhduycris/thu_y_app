import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/image_path.dart';
import '../../../config/style_app/init_style.dart';

class ImageNetWorkView extends StatelessWidget {
  final String imageUrl;
  final String? name;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  BorderRadius? borderRadius;
  bool isSvg;
  bool isLoad;
  bool isAvatar;

  ImageNetWorkView({
    this.height,
    this.width,
    this.fit,
    this.color,
    required this.imageUrl,
    this.borderRadius,
    this.name,
    this.isSvg = false,
    this.isLoad = true,
    this.isAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    double? sizeLoad = height != null
        ? height! * 0.6 > 40
            ? 45
            : height! * 0.6
        : null;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        color: color,
        child: isSvg
            ? SvgPicture.network(
                imageUrl,
                width: width ?? MediaQuery.of(context).size.width,
                height: height,
                fit: fit ?? BoxFit.cover,
                placeholderBuilder: (BuildContext context) => isLoad
                    ? Center(
                        child: SizedBox(
                          width: sizeLoad,
                          height: sizeLoad,
                          child: const CircularProgressIndicator(
                            color: ColorApp.main,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : const SizedBox(),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                color: color,
                fit: fit ?? BoxFit.cover,
                errorWidget: ((context, error, stackTrace) {
                  return Center(
                    child: isAvatar
                        ? const Icon(
                            CupertinoIcons.person,
                            color: ColorApp.main,
                          )
                        : Image.asset(
                            ImagePath.defaultImage,
                            fit: BoxFit.cover,
                            height: height,
                            width: width,
                          ),
                  );
                }),
                progressIndicatorBuilder: (context, url, progress) => isLoad
                    ? Center(
                        child: SizedBox(
                          width: sizeLoad,
                          height: sizeLoad,
                          child: const CircularProgressIndicator(
                            color: ColorApp.main,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
      ),
    );
  }
}
