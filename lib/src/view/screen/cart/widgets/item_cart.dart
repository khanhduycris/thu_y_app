import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/local_bloc/select_index_cubit.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/cart_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/param/add_cart_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/extension/num_ext.dart';
import 'package:thu_y_app/src/config/search_delay.dart';
import 'package:thu_y_app/src/view/widget/dialog/dialog_message.dart';
import 'package:thu_y_app/src/view/widget/item/image_network_view.dart';
import '../../../../blocs/remote_bloc/cart/models/model_cart.dart';
import '../../../../config/style_app/init_style.dart';

class ItemCart extends StatefulWidget {
  ModelCart model;
  bool showIcon;
  Function()? remove;
  Function()? tang;
  Function()? giam;
  Function(bool)? price;

  ItemCart(
      {this.showIcon = true,
      this.remove,
      this.giam,
      this.tang,
      required this.model,
      this.price});

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  bool isRemove = false;

  final cartBloc = BlocCart();
  final indexBloc = SelectIndexCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexBloc.change(widget.model.quantity.validate());
  }

  final delay = SearchDelay();

  giam() {
    if (widget.model.quantity.validate() > widget.model.lowerLimit.validate()) {
      widget.model.quantity = widget.model.quantity.validate() - 1;
      indexBloc.change(widget.model.quantity.validate());
    }
    updateQty();
  }

  tang() {
    if (widget.model.quantity.validate() < widget.model.upperLimit.validate()) {
      widget.model.quantity = widget.model.quantity.validate() + 1;
      indexBloc.change(widget.model.quantity.validate());
    }
    updateQty();
  }

  removeItem() {
    DialogMessage(
      context: context,
      message: "Bạn có muốn sản phẩm này không",
      onConfirm: () {
        isRemove = true;
        finish(context);
        cartBloc.removeCart(widget.model.id.validate());
      },
    );
  }

  updateQty() {
    delay.debounce(() {
      cartBloc.updateQty(
        AddCartParam(
          id: widget.model.id.validate(),
          qty: widget.model.quantity.validate(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocCart, CubitState>(
      bloc: cartBloc,
      listener: (context, state) {
        if (isRemove) {
          CheckStateBloc.check(
            context,
            state,
            isShowMsg: true,
            success: () {
              context.read<BlocListCart>().remove(widget.model);
            },
          );
        } else {
          CheckStateBloc.checkNoLoad(
            context,
            state,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.only(right: 15, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorApp.main.withOpacity(0.3),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageNetWorkView(
                      imageUrl: widget.model.productThumbnailImage.toString(),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.model.productName.validate(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: StyleApp.textStyle700(),
                        ),
                      ),
                      SizedBox(
                        width: widget.showIcon ? 10 : 0,
                      ),
                      widget.showIcon
                          ? InkWell(
                              onTap: removeItem,
                              child: const Icon(
                                Icons.close,
                                color: ColorApp.grey82,
                               // size: 20,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    widget.model.variation ?? "",
                    style: StyleApp.textStyle400(
                      fontSize: 12,
                      color: ColorApp.grey66,
                    ),
                  ),
                  BlocBuilder<SelectIndexCubit, int>(
                      bloc: indexBloc,
                      builder: (context, state) {
                        return Text(
                          "${(widget.model.price.validate() * state).formatPrice()}đ",
                          textAlign: TextAlign.end,
                          style: StyleApp.textStyle700(color: Colors.red),
                        );
                      }),
                  if (widget.showIcon) buidQty(),
                ],
              ).paddingSymmetric(vertical: 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget buidQty() {
    return BlocBuilder<BlocCart, CubitState>(
      bloc: cartBloc,
      builder: (context, state) {
        if (state.status == BlocStatus.loading && !isRemove) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CircularProgressIndicator(
                color: ColorApp.main,
                strokeWidth: 2,
              ).withSize(width: 22, height: 22),
            ],
          ).paddingTop(10);
        }
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text("Khuyến mãi >", style: StyleApp.textStyle400(color: ColorApp.main, fontSize: 12),),
              const Spacer(),
              InkWell(
                onTap: giam,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorApp.greyF2,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.remove,
                    color: ColorApp.main,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              BlocBuilder<SelectIndexCubit, int>(
                  bloc: indexBloc,
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: StyleApp.textStyle400(
                        fontSize: 14,
                        color: ColorApp.grey66,
                      ),
                    );
                  }),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: tang,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorApp.main,
                    //border: Border.all(color: colorGrey9 ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
