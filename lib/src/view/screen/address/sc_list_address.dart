import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/widget_ext.dart';
import 'package:thu_y_app/src/view/screen/address/sc_create_address.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/load/load_page.dart';

import '../../../blocs/remote_bloc/address/bloc_list_address.dart';
import '../../../blocs/remote_bloc/address/models/model_address.dart';
import '../../../config/style_app/init_style.dart';
import 'widgets/item_address.dart';

class SCListAddress extends StatelessWidget {
  bool checkChoice;

  SCListAddress({
    this.checkChoice = false,
    this.modelAddress,
  });

  final blocListAddress = BlocListAddress()..getList();

  ModelAddress? modelAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Địa chỉ nhận hàng",
        actions: [
          IconButton(
            onPressed: () async {
              CreateAddress().nextPage(context).then((value) {
                if (value == true) {
                  blocListAddress.getList();
                }
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => blocListAddress.getList(),
        child: BlocBuilder(
          bloc: blocListAddress,
          builder: (_, CubitState state) {
            return LoadPage(
              state: state,
              height: null,
              reLoad: () => blocListAddress.getList(),
              child: blocListAddress.list.isNotEmpty
                  ? ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      itemCount: blocListAddress.list.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => ItemAddress(
                        model: blocListAddress.list[index],
                        onTap: () {
                          if (checkChoice) {
                            finish(context, blocListAddress.list[index]);
                          } else {
                            CreateAddress(
                              modelAddress: blocListAddress.list[index],
                            ).nextPage(context).then((value) {
                              if (value == true) {
                                blocListAddress.getList();
                              }
                            });
                          }
                        },
                        isChosse:
                            modelAddress?.id == blocListAddress.list[index].id,
                      ),
                    )
                  : Center(
                      child: Text(
                        "Danh sách trống",
                        style: StyleApp.textStyle400(),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
