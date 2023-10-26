import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/config/extension/string_ext.dart';
import '../../../../blocs/remote_bloc/address/models/model_address.dart';
import '../../../../config/style_app/init_style.dart';

class ItemAddress extends StatefulWidget {
  ModelAddress model;
  Function()? onTap;
  bool isChosse;

  ItemAddress({
    required this.model,
    this.onTap,
    this.isChosse = false,
  });

  @override
  State<ItemAddress> createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: widget.isChosse ? const EdgeInsets.all(10) : null,
        decoration: widget.isChosse
            ? BoxDecoration(
                border: Border.all(color: ColorApp.main, width: 1),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.model.name.validate(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleApp.textStyle400(color: ColorApp.grey4F),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  decoration: BoxDecoration(
                      color: ColorApp.main,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    widget.model.phone.validate(),
                    style: StyleApp.textStyle400(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.model.address.formatAddress() +
                  widget.model.wardName.formatAddress() +
                  widget.model.districtName.formatAddress() +
                  widget.model.provinceName.validate(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: StyleApp.textStyle400(color: ColorApp.grey4F),
            )
          ],
        ),
      ),
    );
  }
}
