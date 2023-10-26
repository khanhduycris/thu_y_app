import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

extension WidgetExtension on Widget {
  Future<T?> nextPage<T>(
    BuildContext context, {
    bool isNewTask = false,
    bool isLogin = true,
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
  }) async {
    if (isNewTask) {
      return await Navigator.of(context).pushAndRemoveUntil(
        buildPageRoute(isLogin ? this : Container(),
            pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
        (route) => false,
      );
    } else {
      return await Navigator.of(context).push(
        buildPageRoute(isLogin ? this : Container(),
            pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      );
    }
  }

  Future showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) => this,
    );
  }

  Widget scrollView({
    EdgeInsets? padding,
    ScrollController? controller,
    Axis scrollDirection = Axis.vertical,
  }) {
    return SingleChildScrollView(
      padding: padding,
      controller: controller,
      scrollDirection: scrollDirection,
      physics: const AlwaysScrollableScrollPhysics(),
      child: this,
    );
  }
}
