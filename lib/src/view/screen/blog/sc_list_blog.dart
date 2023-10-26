import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/font_end/bloc_news.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/loading_more.dart';

import '../../../config/style_app/init_style.dart';
import '../../widget/load/load_more_list.dart';
import 'widgets/item_blog.dart';

class ScListBlog extends StatefulWidget {
  const ScListBlog({Key? key}) : super(key: key);

  @override
  State<ScListBlog> createState() => _ScListBlogState();
}

class _ScListBlogState extends State<ScListBlog> {
  final blocNews = BlocNews();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocNews.getList();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        blocNews.onMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Tin tức"),
      body: RefreshIndicator(
        onRefresh: () => blocNews.getList(),
        child: BlocBuilder(
          bloc: blocNews,
          builder: (_, CubitState state) {
            return LoadingMore(
              state: state,
              height: null,
              reLoad: () => blocNews.getList(),
              isMore: state.status == BlocStatus.loading &&
                  blocNews.news.isNotEmpty,
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ItemBlog(
                        modelNew: blocNews.news[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: blocNews.news.length,
                    ),
                    LoadMoreList(
                      isLoad: state.status == BlocStatus.loading &&
                          blocNews.news.isNotEmpty,
                      isMax: false,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
