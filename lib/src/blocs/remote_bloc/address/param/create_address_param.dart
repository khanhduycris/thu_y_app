class CreateAddressParam {
  String address;
  String phone;
  String province;
  String district;
  String ward;
  int? id;

  CreateAddressParam({
    required this.ward,
    required this.district,
    required this.province,
    required this.phone,
    required this.address,
    this.id,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> req = {
      "address": address,
      "province_id": province,
      "district_id": district,
      "ward_id": ward,
      "phone": phone,
    };
    if (id != null) {
      req['id'] = id;
    }
    return req;
  }
}
