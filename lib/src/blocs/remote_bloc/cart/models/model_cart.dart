import 'package:equatable/equatable.dart';

class ModelCart extends Equatable {
  int? id;
  int? userId;
  int? productId;
  String? productName;
  String? productThumbnailImage;
  String? variation;
  int? price;
  String? currencySymbol;
  int? tax;
  int? shippingCost;
  int? quantity;
  int? productGiftId;
  int? lowerLimit;
  int? upperLimit;

  ModelCart({
    this.id,
    this.userId,
    this.productId,
    this.productName,
    this.productThumbnailImage,
    this.variation,
    this.price,
    this.currencySymbol,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.productGiftId,
    this.lowerLimit,
    this.upperLimit,
  });

  ModelCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productThumbnailImage = json['product_thumbnail_image'];
    variation = json['variation'];
    price = json['price'].round();
    currencySymbol = json['currency_symbol'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    productGiftId = json['product_gift_id'];
    lowerLimit = json['lower_limit'];
    upperLimit = json['upper_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_thumbnail_image'] = this.productThumbnailImage;
    data['variation'] = this.variation;
    data['price'] = this.price;
    data['currency_symbol'] = this.currencySymbol;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    data['product_gift_id'] = this.productGiftId;
    data['lower_limit'] = this.lowerLimit;
    data['upper_limit'] = this.upperLimit;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, variation];
}
