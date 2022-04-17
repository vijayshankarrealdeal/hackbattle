class FamousItems {
  FamousItems({
    required this.productName,
    required this.productPrice,
    required this.orderItemQuantity,
  });
  late final String productName;
  late final num productPrice;
  late final num orderItemQuantity;

  FamousItems.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    orderItemQuantity = json['order_item_quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['product_price'] = productPrice;
    _data['order_item_quantity'] = orderItemQuantity;
    return _data;
  }
}
