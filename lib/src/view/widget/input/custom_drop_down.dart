import 'package:flutter/material.dart';

import '../../../config/style_app/init_style.dart';

class CustomDropDown extends StatefulWidget {
  List listItem;
  String hint;
  dynamic value;
  ValueChanged onChanged;
  Function(dynamic)? validator;
  double? radius;
  Color? fillColor;


  CustomDropDown({
    required this.listItem,
    required this.hint,
    this.value,
    required this.onChanged,
    this.fillColor,
    this.radius,
    this.validator,
  });

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      onChanged: (val) {
        return widget.onChanged(val);
      },
      isExpanded: true,
      style: StyleApp.textStyle400(),
      validator:(value) {
        if(widget.validator != null){
          return  widget.validator!(value);
        }
        return null;
      },
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.hint,
          style: StyleApp.textStyle400(color: ColorApp.grey82),
        ),
      ),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 50),
            borderSide: BorderSide(
              color: ColorApp.main.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 50),
            borderSide: const BorderSide(
              color: ColorApp.main,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 50),
            borderSide: const BorderSide(
              color: ColorApp.main,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 50),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          filled: true,
          fillColor: widget.fillColor ?? ColorApp.main.withOpacity(0.03),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
      items: List.generate(
        widget.listItem.length,
        (index) => DropdownMenuItem(
          value: widget.listItem[index],
          child: Text(
            widget.listItem[index].name.toString(),
            style: StyleApp.textStyle400(),
          ),
        ),
      ),
    );
  }
}
