class ModelCoupon {
  int? id;
  String? code;
  int? discount;
  String? discountType;
  int? endDate;
  int? startDate;
  String? image;
  String? description;

  ModelCoupon(
      {this.id,
        this.code,
        this.discount,
        this.discountType,
        this.endDate,
        this.startDate,
        this.image,
        this.description});

  ModelCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    discountType = json['discount_type'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
