import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/enum/bloc_status.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/bloc_address.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/bloc_location.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_address.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/models/model_local.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/address/param/create_address_param.dart';
import 'package:thu_y_app/src/blocs/remote_bloc/cart/param/add_cart_param.dart';
import 'package:thu_y_app/src/blocs/state/check_state.dart';
import 'package:thu_y_app/src/blocs/state/cubit_state.dart';
import 'package:thu_y_app/src/config/validator.dart';
import 'package:thu_y_app/src/view/widget/app_bar/app_bar_custom.dart';
import 'package:thu_y_app/src/view/widget/button/custom_button.dart';
import 'package:thu_y_app/src/view/widget/button/custom_nav_btn.dart';
import 'package:thu_y_app/src/view/widget/input/custom_drop_down.dart';
import 'package:thu_y_app/src/view/widget/input/input_text.dart';

import '../../../config/style_app/init_style.dart';

class CreateAddress extends StatefulWidget {
  ModelAddress? modelAddress;

  CreateAddress({this.modelAddress});

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final blocProvince = BlocLocation();
  final blocDistrict = BlocLocation();
  final blocWard = BlocLocation();
  final blocAddress = BlocAddress();

  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocProvince.getProvince();
    if (widget.modelAddress != null) {
      phone.text = widget.modelAddress?.phone ?? "";
      address.text = widget.modelAddress?.address ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: widget.modelAddress != null ? "Sửa địa chỉ" : "Thêm địa chỉ",
        actions: [
          if (widget.modelAddress != null)
            IconButton(
              onPressed: () =>
                  blocAddress.remove(widget.modelAddress!.id.validate()),
              icon: const Icon(
                CupertinoIcons.delete,
                color: Colors.white,
              ),
            ),
        ],
      ),
      bottomNavigationBar: BlocConsumer<BlocAddress, CubitState>(
        bloc: blocAddress,
        listener: (context, state) {
          CheckStateBloc.checkNoLoad(
            context,
            state,
            success: () => finish(context, true),
          );
        },
        builder: (context, state) {
          return CustomNavBtn(
            title: "Xác nhận",
            isLoad: state.status == BlocStatus.loading,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final param = CreateAddressParam(
                  ward: blocWard.ward?.id ?? "",
                  district: blocDistrict.district?.id ?? "",
                  province: blocProvince.province?.id ?? "",
                  phone: phone.text,
                  address: address.text,
                  id: widget.modelAddress?.id,
                );

                if (widget.modelAddress != null) {
                  blocAddress.update(param);
                } else {
                  blocAddress.create(param);
                }
              }
            },
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextIcon(
                prefix: const Icon(
                  Icons.edit,
                  color: ColorApp.black,
                  size: 17,
                ),
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                expandedText: true,
                text: "Số điện thoại",
                textStyle: StyleApp.textStyle700(),
              ),
              InputText(
                hintText: "Nhập",
                textFieldType: TextFieldType.NUMBER,
                controller: phone,
                radius: 5,
                validator: (p0) => ValidatorApp.checkPhone(text: p0),
              ),
              10.height,
              TextIcon(
                prefix: const Icon(
                  Icons.edit,
                  color: ColorApp.black,
                  size: 17,
                ),
                edgeInsets: const EdgeInsets.symmetric(vertical: 10),
                expandedText: true,
                text: "Địa chỉ nhận hàng",
                textStyle: StyleApp.textStyle700(),
              ),
              BlocConsumer<BlocLocation, CubitState>(
                bloc: blocProvince,
                listener: (context, state) {
                  if (state.status == BlocStatus.success &&
                      blocProvince.province == null &&
                      widget.modelAddress != null) {
                    blocProvince.setValue(
                      value: ModelLocal(
                        id: widget.modelAddress!.provinceId
                            .validate()
                            .toString(),
                        name: widget.modelAddress!.provinceName.validate(),
                      ),
                    );
                    blocDistrict.getDistrict(
                        widget.modelAddress!.provinceId.validate().toString());
                  }
                },
                builder: (context, state) {
                  return CustomDropDown(
                    listItem: blocProvince.provinces,
                    radius: 5,
                    hint: 'Tỉnh/Thành phố',
                    value: blocProvince.province,
                    onChanged: (value) {
                      blocWard.wards.clear();
                      blocProvince.setValue(value: value);
                      blocDistrict.setValue();
                      blocWard.setValue();
                      blocDistrict.getDistrict(value.id);
                    },
                    validator: (p0) {
                      if (p0 == null) {
                        return "Không bỏ trống";
                      }
                      return null;
                    },
                  );
                },
              ),
              15.height,
              BlocConsumer<BlocLocation, CubitState>(
                bloc: blocDistrict,
                listener: (context, state) {
                  if (state.status == BlocStatus.success &&
                      blocDistrict.district == null &&
                      widget.modelAddress != null) {
                    blocDistrict.setValue(
                      value: ModelLocal(
                        id: widget.modelAddress!.districtId
                            .validate()
                            .toString(),
                        name: widget.modelAddress!.districtName.validate(),
                      ),
                    );
                    blocWard.getWard(
                        widget.modelAddress!.districtId.validate().toString());
                  }
                },
                builder: (context, state) {
                  return CustomDropDown(
                    listItem: blocDistrict.districts,
                    radius: 5,
                    hint: 'Quận/Huyện',
                    value: blocDistrict.district,
                    onChanged: (value) {
                      blocDistrict.setValue(value: value);
                      blocWard.setValue();
                      blocWard.getWard(value.id);
                    },
                    validator: (p0) {
                      if (p0 == null) {
                        return "Không bỏ trống";
                      }
                      return null;
                    },
                  );
                },
              ),
              15.height,
              BlocConsumer<BlocLocation, CubitState>(
                bloc: blocWard,
                listener: (context, state) {
                  if (state.status == BlocStatus.success &&
                      blocWard.ward == null &&
                      widget.modelAddress != null) {
                    blocWard.setValue(
                      value: ModelLocal(
                        id: widget.modelAddress!.wardId.validate().toString(),
                        name: widget.modelAddress!.wardName.validate(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomDropDown(
                    listItem: blocWard.wards,
                    radius: 5,
                    value: blocWard.ward,
                    hint: 'Phường/Xã',
                    onChanged: (value) {
                      blocWard.setValue(value: value);
                    },
                    validator: (p0) {
                      if (p0 == null) {
                        return "Không bỏ trống";
                      }
                      return null;
                    },
                  );
                },
              ),
              15.height,
              InputText(
                hintText: "Thôn/xóm/số nhà",
                controller: address,
                radius: 5,
                validator: (p0) =>
                    ValidatorApp.checkNull(text: p0, isTextFiled: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
