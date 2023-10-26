import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/image_path.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

import 'menu_search_app_bar.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  bool isMenu;
  bool isSearch;
  String title;
  Widget? leading;

  Function(String)? onChange;

  AppBarCustom({
    this.actions,
    this.isMenu = false,
    this.isSearch = false,
    required this.title,
    this.onChange,
    this.leading,
  });

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paddingStatusBar = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(
        color: ColorApp.main,
        image: DecorationImage(
          image: AssetImage(ImagePath.appbar),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: paddingStatusBar + 5,
          ),
          if (isMenu) MenuSearchAppBar(),
          NavigationToolbar(
            leading: leading ??
                (ModalRoute.of(context)?.canPop == true
                    ? BackButton(
                        color: Colors.white,
                        onPressed: () {
                          finish(context);
                        },
                      )
                    : null),
            middleSpacing: 0,
            middle: isSearch
                ? AppTextField(
                    textFieldType: TextFieldType.NAME,
                    onChanged: onChange,
                    controller: controller,
                    cursorColor: ColorApp.main,
                    textStyle: StyleApp.textStyle500(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: StyleApp.textStyle400(color: ColorApp.grey82),
                      hintText: "Nhập từ khóa",
                      suffixIcon: InkWell(
                        onTap: () {
                          if (onChange != null) {
                            onChange!(controller.text);
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          color: ColorApp.black,
                        ),
                      ),
                    ),
                  ).paddingRight(actions == null ? 15 : 0)
                : Text(
                    title,
                    style: StyleApp.textStyle700(
                        color: Colors.white, fontSize: 16),
                  ).paddingRight(actions == null ? 15 : 0),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions ?? [],
            ),
          ).withHeight(40),
          10.height,
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(isMenu ? 105 : 55);
}
