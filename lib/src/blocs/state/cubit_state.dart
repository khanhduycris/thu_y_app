import '../enum/address_status.dart';
import '../enum/bloc_status.dart';

class CubitState {
  BlocStatus status;
  AddressStatus addressStatus;
  dynamic data;
  String msg;
  int total;

  CubitState({
    this.status = BlocStatus.initial,
    this.addressStatus = AddressStatus.initial,
    this.total = 0,
    this.data,
    this.msg = "Lỗi. Kết nối tới máy chủ thất bại",
  });

  CubitState copyWith({
    BlocStatus? status,
    AddressStatus? addressStatus,
    dynamic data,
    String? msg,
    int? total,
  }) {
    return CubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      msg: msg ?? this.msg,
      total: total ?? this.total,
      addressStatus: addressStatus ?? this.addressStatus,
    );
  }
}
