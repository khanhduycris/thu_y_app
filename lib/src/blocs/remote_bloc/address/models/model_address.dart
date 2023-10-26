class ModelAddress {
  int? id;
  int? userId;
  String? address;
  String? name;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? wardId;
  String? wardName;
  String? phone;
  int? setDefault;
  bool? locationAvailable;
  double? lat;
  double? lang;

  ModelAddress(
      {this.id,
        this.userId,
        this.address,
        this.provinceId,
        this.provinceName,
        this.districtId,
        this.districtName,
        this.wardId,
        this.wardName,
        this.phone,
        this.name,
        this.setDefault,
        this.locationAvailable,
        this.lat,
        this.lang});

  ModelAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    name = json['name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    wardId = json['ward_id'];
    wardName = json['ward_name'];
    phone = json['phone'];
    setDefault = json['set_default'];
    locationAvailable = json['location_available'];
    lat = json['lat'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['ward_id'] = this.wardId;
    data['ward_name'] = this.wardName;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['set_default'] = this.setDefault;
    data['location_available'] = this.locationAvailable;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    return data;
  }
}
