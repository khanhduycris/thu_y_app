import 'package:flutter/material.dart';

import '../../../blocs/state/cubit_state.dart';
import 'load_page.dart';

class LoadingMore extends StatelessWidget {
  CubitState state;
  bool isMore;
  Widget child;
  Function()? reLoad;
  String? message;
  double? height;
  Widget? loadChild;

  LoadingMore({
    required this.state,
    this.isMore = false,
    required this.child,
    this.height = 200,
    this.reLoad,
    this.message,
    this.loadChild,
  });

  @override
  Widget build(BuildContext context) {
    if (isMore) {
      return child;
    }
    return LoadPage(
      state: state,
      child: child,
      height: height,
      message: message,
      reLoad: reLoad,
      loadChild: loadChild,
    );
  }
}
