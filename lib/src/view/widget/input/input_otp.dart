import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../config/style_app/init_style.dart';

class InputOtp extends StatefulWidget {
  final int pinLength;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  final bool showUnderline;
  final InputDecoration? decoration;

  final double fieldWidth;
  final TextStyle? textStyle;

  InputOtp({
    this.pinLength = 4,
    this.fieldWidth = 40,
    this.onChanged,
    this.onCompleted,
    this.showUnderline = false,
    this.decoration,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  InputOtpState createState() => InputOtpState();
}

class InputOtpState extends State<InputOtp> {
  List<OTPLengthModel> list = [];
  FocusNode focusNode = FocusNode();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    list.addAll(List.generate(widget.pinLength, (index) {
      return OTPLengthModel(
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
      );
    }).toList());
  }

  String get concatText {
    String text = '';

    list.forEach((element) {
      if (text.isEmpty) {
        text = element.textEditingController!.text;
      } else {
        text = '$text${element.textEditingController!.text}';
      }
    });

    return text;
  }

  void moveToNextFocus(int index) async {
    if (index == (list.length - 1)) {
      widget.onCompleted?.call(concatText);
    } else {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[index + 1].focusNode!);

      setTextSelection(index + 1);
    }
  }

  void moveToPreviousFocus(int index) async {
    if (index >= 1) {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[index - 1].focusNode!);

      setTextSelection(index - 1);
    } else {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[0].focusNode!);

      setTextSelection(0);
    }
  }

  void setTextSelection(int index) {
    currentIndex = index;

    list[index].textEditingController!.selection = TextSelection(
      baseOffset: 0,
      extentOffset: list[index].textEditingController!.text.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    list.forEach((element) {
      element.textEditingController?.dispose();
      element.focusNode?.dispose();
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(list.length, (index) {
        return Container(
          width: widget.fieldWidth,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: list[index].textEditingController,
            focusNode: list[index].focusNode,
            keyboardType: TextInputType.number,
            style: widget.textStyle,
            cursorColor: ColorApp.main,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            maxLength: 1,
            decoration: InputDecoration(
              fillColor: ColorApp.main.withOpacity(0.03),
              filled: true,
              counter: const Offstage(),
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorApp.main.withOpacity(
                    0.3,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorApp.main.withOpacity(
                    0.3,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            textAlign: TextAlign.center,
            onSubmitted: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
                moveToNextFocus(index);
              }
            },
            onChanged: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
                moveToNextFocus(index);
              }
              widget.onChanged?.call(concatText);

              setState(() {});
            },
            onTap: () async {
              context.unFocus(list[index].focusNode!);
              await 1.milliseconds.delay;
              context.requestFocus(list[index].focusNode!);
              setTextSelection(index);
            },
          ),
        );
      }),
    );
  }
}
