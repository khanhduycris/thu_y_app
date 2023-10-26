import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../config/image_path.dart';
import '../../../config/style_app/init_style.dart';
import '../item/load_shimmer.dart';
import '../list/grid_view_custom.dart';

Widget LoadingPrd() {
  return LoadShimmer(
    isLoading: true,
    child: GridViewCustom(
      itemCount: 18,
      showFull: true,
      maxWight: 116,
      mainAxisExtent: 206,
      shrinkWrap: true,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: ColorApp.greyE9,
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 104,
              alignment: Alignment.center,
              child: Image.asset(
                ImagePath.logo,
                height: 70,
                width: 70,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    5.height,
                    Container(
                      height: 10,
                      margin: const EdgeInsets.only(right: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    5.height,
                    Container(
                      height: 10,
                      margin: const EdgeInsets.only(right: 50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    5.height,
                    const Spacer(),
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget LoadingPrdHoz() {
  return LoadShimmer(
    isLoading: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 20,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        15.height,
        ListView.separated(
          itemCount: 7,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          separatorBuilder: (context, index) => 15.width,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            width: 116,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: ColorApp.greyE9,
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 104,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.logo,
                    height: 70,
                    width: 70,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        const Spacer(),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).withHeight(206),
      ],
    ),
  );
}

Widget LoadingCatePrd() {
  return LoadShimmer(
    isLoading: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => 15.width,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            height: 15,
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ).withHeight(35),
        GridViewCustom(
          itemCount: 18,
          showFull: true,
          maxWight: 116,
          mainAxisExtent: 206,
          shrinkWrap: true,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: ColorApp.greyE9,
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 104,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.logo,
                    height: 70,
                    width: 70,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        Container(
                          height: 10,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        5.height,
                        const Spacer(),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).expand(),
      ],
    ),
  );
}

Widget loadDetailPrd() {
  return Container(
    color: Colors.white,
    child: LoadShimmer(
      isLoading: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Center(
                child: Image.asset(
                  ImagePath.logo,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            15.height,
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            10.height,
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 15,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            10.height,
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 15,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            35.height,
            LoadingPrdHoz(),
          ],
        ),
      ),
    ),
  );
}

Widget LoadingCart({
  bool isList = true,
}) {
  return LoadShimmer(
    isLoading: true,
    child: ListView.separated(
      itemCount: 7,
      shrinkWrap: !isList,
      physics: isList
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      separatorBuilder: (context, index) => 15.height,
      itemBuilder: (context, index) => Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: ColorApp.greyE9,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              ImagePath.logo,
              height: 70,
              width: 70,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    5.height,
                    Container(
                      height: 10,
                      margin: const EdgeInsets.only(right: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    5.height,
                    const Spacer(),
                    Container(
                      height: 10,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
