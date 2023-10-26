import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

import 'input_text.dart';

class InputTitleColumn extends StatelessWidget {
  TextFieldType textFieldType;
  Widget? prefixIcon;
  String? hintText;
  String label;

  TextEditingController? controller;
  Function(String value)? onChanged;
  Function(String)? validator;
  Function()? onTap;
  Widget? suffixIcon;
  int maxLines;
  int? maxLength;
  double? radius;
  Color? fillColor;

  InputTitleColumn({
    this.textFieldType = TextFieldType.NAME,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.validator,
    this.radius = 5,
    this.fillColor = Colors.transparent,
    required this.label,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: StyleApp.textStyle700(),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          radius: radius,
          fillColor: fillColor,
          onTap: onTap,
          controller: controller,
          hintText: hintText,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          textFieldType: textFieldType,
        ),
      ],
    );
  }
}
