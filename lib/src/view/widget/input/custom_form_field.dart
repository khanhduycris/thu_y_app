import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../config/style_app/init_style.dart';

class CustomFormField extends StatefulWidget {
  Function(dynamic)? validator;
  Widget? child;

  CustomFormField({
    this.validator,
    this.child,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "name",
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          child: widget.child,
          decoration: InputDecoration(
            errorText: field.errorText,
            errorStyle: StyleApp.textStyle400(
              color: Colors.red,
              fontSize: 10,
            ),
            contentPadding: EdgeInsets.zero,
            errorMaxLines: 2,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        );
      },
    );
  }
}
