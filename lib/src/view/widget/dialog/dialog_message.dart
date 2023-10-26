import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/style_app/init_style.dart';

DialogMessage({
  required BuildContext context,
  required String message,
  String title = "Thông báo",
  Function()? onConfirm,
  Function()? onCancel,
}) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: ColorApp.main,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        message,
        style: GoogleFonts.roboto(
          color: ColorApp.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        if (onConfirm != null) ...[
          TextButton(
            onPressed: onConfirm,
            child: Text(
              "Đồng ý",
              style: GoogleFonts.roboto(
                color: ColorApp.main,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
        TextButton(
          onPressed: onCancel ??
              () {
                Navigator.pop(context);
              },
          child: Text(
            "Đóng",
            style: GoogleFonts.roboto(
              color: ColorApp.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
