import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../config/image_path.dart';

class BackGroundForm extends StatelessWidget {
  Widget child;
  BackGroundForm({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                ImagePath.formTop,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                ImagePath.formTim,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                ImagePath.formBanChan,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                ImagePath.formImageBottom,
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: child,
            ),
            if (ModalRoute.of(context)?.canPop == true)
              Positioned(
                left: 0,
                top: MediaQuery.of(context).padding.top,
                child: BackButton(
                  onPressed: () {
                    finish(context);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
