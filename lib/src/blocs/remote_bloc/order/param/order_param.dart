class OrderParam{
  int page;
  int limit;
  String delivery_status;

  OrderParam({
    required this.page,
    required this.limit,
    required this.delivery_status,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'limit': this.limit,
      'delivery_status': this.delivery_status,
    };
  }

}