class AddCartParam {
  int id;
  int qty;
  String? variant;

  AddCartParam({
    required this.id,
    required this.qty,
    this.variant,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> req = {
      'id': this.id,
      'quantity': this.qty,
    };
    if (variant != null) {
      req['variant'] = this.variant;
    }
    return req;
  }
}
