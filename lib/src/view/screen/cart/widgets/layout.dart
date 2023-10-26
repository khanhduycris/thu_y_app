import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/style_app/init_style.dart';

Widget CustomListile({
  required String path,
  required String title,
  required String titleButton,
  Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
    child: Row(
      children: [
        Image.asset(path, height: 18),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleApp.textStyle700(),
          ),
        ),
        if (onTap != null) ...[
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: ColorApp.main.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                titleButton,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    StyleApp.textStyle400(fontSize: 12, color: ColorApp.main),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget buildRow({required String title, required String content}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: StyleApp.textStyle400(
            color: ColorApp.grey4F,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: StyleApp.textStyle600(
              color: ColorApp.grey66,
            ),
          ),
        )
      ],
    ),
  );
}
