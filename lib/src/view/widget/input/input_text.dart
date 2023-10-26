import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/style_app/init_style.dart';

class InputText extends StatelessWidget {
  TextFieldType textFieldType;
  Widget? prefixIcon;
  String? hintText;

  TextEditingController? controller;
  Function(String value)? onChanged;
  Function(String)? validator;
  Function()? onTap;
  Widget? suffixIcon;
  int maxLines;
  int? maxLength;
  double? radius;
  Color? fillColor;

  InputText({
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
    this.radius,
    this.fillColor,
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: ColorApp.main,
            ),
      ),
      child: AppTextField(
        textFieldType: textFieldType,
        controller: controller,
        onTap: onTap,
        readOnly: onTap != null,
        onChanged: onChanged,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: (val) {
          if (validator != null) {
            return validator!(val ?? "");
          }
          return null;
        },
        cursorColor: ColorApp.main,
        textStyle: StyleApp.textStyle500(),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: StyleApp.textStyle400(color: ColorApp.grey82),
          errorStyle: StyleApp.textStyle400(color: Colors.red, fontSize: 10),
          filled: true,
          fillColor: fillColor ?? ColorApp.main.withOpacity(0.03),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 50),
            borderSide: BorderSide(
              color: ColorApp.main.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ??50),
            borderSide: const BorderSide(
              color: ColorApp.main,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ??50),
            borderSide: const BorderSide(
              color: ColorApp.main,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ??50),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
