import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/style_app/init_style.dart';

DialogLoading(
  BuildContext context,
) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: ColorApp.main,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Đang tải...",
                style: GoogleFonts.nunito(
                  color: ColorApp.main,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
