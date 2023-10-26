import 'dart:convert';

class ModelOrder {
  int? id;
  int? combinedOrderId;
  int? userId;
  dynamic guestId;
  int? sellerId;
  ShipAddress? shippingAddress;
  String? shippingType;
  int? pickupPointId;
  String? deliveryStatus;
  String? paymentType;
  String? paymentStatus;
  dynamic paymentDetails;
  int? grandTotal;
  int? couponDiscount;
  String? code;
  dynamic trackingCode;
  int? date;
  int? viewed;
  int? deliveryViewed;
  int? paymentStatusViewed;
  int? commissionCalculated;
  int? stockId;
  String? createdAt;
  String? updatedAt;
  List<OrderDetails>? orderDetails;

  ModelOrder(
      {this.id,
      this.combinedOrderId,
      this.userId,
      this.guestId,
      this.sellerId,
      this.shippingAddress,
      this.shippingType,
      this.pickupPointId,
      this.deliveryStatus,
      this.paymentType,
      this.paymentStatus,
      this.paymentDetails,
      this.grandTotal,
      this.couponDiscount,
      this.code,
      this.trackingCode,
      this.date,
      this.viewed,
      this.deliveryViewed,
      this.paymentStatusViewed,
      this.commissionCalculated,
      this.stockId,
      this.createdAt,
      this.updatedAt,
      this.orderDetails});

  ModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    combinedOrderId = json['combined_order_id'];
    userId = json['user_id'];
    guestId = json['guest_id'];
    sellerId = json['seller_id'];
    shippingAddress = ShipAddress.fromJson(json['shipping_address'] ?? "");
    shippingType = json['shipping_type'];
    pickupPointId = json['pickup_point_id'];
    deliveryStatus = json['delivery_status'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    paymentDetails = json['payment_details'];
    grandTotal = int.tryParse(json['grand_total'].toString());
    couponDiscount = int.tryParse(json['coupon_discount'].toString());
    code = json['code'];
    trackingCode = json['tracking_code'];
    date = json['date'];
    viewed = json['viewed'];
    deliveryViewed = json['delivery_viewed'];
    paymentStatusViewed = json['payment_status_viewed'];
    commissionCalculated = json['commission_calculated'];
    stockId = json['stock_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['combined_order_id'] = this.combinedOrderId;
    data['user_id'] = this.userId;
    data['guest_id'] = this.guestId;
    data['seller_id'] = this.sellerId;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_type'] = this.shippingType;
    data['pickup_point_id'] = this.pickupPointId;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['payment_details'] = this.paymentDetails;
    data['grand_total'] = this.grandTotal;
    data['coupon_discount'] = this.couponDiscount;
    data['code'] = this.code;
    data['tracking_code'] = this.trackingCode;
    data['date'] = this.date;
    data['viewed'] = this.viewed;
    data['delivery_viewed'] = this.deliveryViewed;
    data['payment_status_viewed'] = this.paymentStatusViewed;
    data['commission_calculated'] = this.commissionCalculated;
    data['stock_id'] = this.stockId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  int? productId;
  String? variation;
  int? price;
  int? tax;
  int? shippingCost;
  int? quantity;
  String? name;
  String? thumbnailImage;

  OrderDetails(
      {this.id,
      this.productId,
      this.variation,
      this.price,
      this.tax,
      this.shippingCost,
      this.quantity,
      this.name,
      this.thumbnailImage});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    name = json['name'];
    thumbnailImage = json['thumbnail_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['variation'] = this.variation;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['thumbnail_image'] = this.thumbnailImage;
    return data;
  }
}

class ShipAddress {
  String? name;
  String? email;
  String? address;
  String? province;
  String? district;
  String? ward;
  String? phone;

  ShipAddress(
      {this.name,
      this.email,
      this.address,
      this.province,
      this.district,
      this.ward,
      this.phone});

  ShipAddress.fromJson(String shipaddress) {
    Map<String, dynamic> jsonData = json.decode(shipaddress);
    name = jsonData['name'];
    email = jsonData['email'];
    address = jsonData['address'];
    province = jsonData['province'];
    district = jsonData['district'];
    ward = jsonData['ward'];
    phone = jsonData['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['phone'] = this.phone;
    return data;
  }
}
