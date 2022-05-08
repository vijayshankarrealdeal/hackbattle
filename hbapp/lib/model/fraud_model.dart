class FraudData {
  FraudData({
    required this.transferType,
    required this.daysForShippingReal,
    required this.daysForShipmentScheduled,
    required this.benefitPerOrder,
    required this.salesPerCustomer,
    required this.deliveryStatus,
    required this.lateDeliveryRisk,
    required this.categoryId,
    required this.customerId,
    required this.customerSegment,
    required this.customerZipcode,
    required this.departmentId,
    required this.latitude,
    required this.longitude,
    required this.orderCustomerId,
    required this.orderId,
    required this.orderItemCardprodId,
    required this.orderItemDiscount,
    required this.orderItemDiscountRate,
    required this.orderItemId,
    required this.orderItemProductPrice,
    required this.orderItemProfitRatio,
    required this.orderItemQuantity,
    required this.sales,
    required this.orderItemTotal,
    required this.orderProfitPerOrder,
    required this.productCardId,
    required this.productCategoryId,
    required this.productPrice,
    required this.productStatus,
    required this.shippingMode,
    required this.fraud,
  });
  late final String transferType;
  late final num daysForShippingReal;
  late final num daysForShipmentScheduled;
  late final num benefitPerOrder;
  late final num salesPerCustomer;
  late final String deliveryStatus;
  late final num lateDeliveryRisk;
  late final num categoryId;
  late final num customerId;
  late final String customerSegment;
  late final num customerZipcode;
  late final num departmentId;
  late final num latitude;
  late final num longitude;
  late final String orderCustomerId;
  late final num orderId;
  late final num orderItemCardprodId;
  late final num orderItemDiscount;
  late final num orderItemDiscountRate;
  late final num orderItemId;
  late final num orderItemProductPrice;
  late final num orderItemProfitRatio;
  late final num orderItemQuantity;
  late final num sales;
  late final num orderItemTotal;
  late final num orderProfitPerOrder;
  late final num productCardId;
  late final num productCategoryId;
  late final num productPrice;
  late final num productStatus;
  late final String shippingMode;
  late final num fraud;

  FraudData.fromJson(Map<String, dynamic> json) {
    transferType = json['transfer_type'];
    daysForShippingReal = json['days_for_shipping_real'] as num;
    daysForShipmentScheduled = json['days_for_shipment_scheduled'] as num;
    benefitPerOrder = json['benefit_per_order'] as num;
    salesPerCustomer = json['sales_per_customer'] as num;
    deliveryStatus = json['delivery_status'];
    lateDeliveryRisk = json['late_delivery_risk'] as num;
    categoryId = json['category_id'] as num;
    customerId = json['customer_id'] as num;
    customerSegment = json['customer_segment'];
    customerZipcode = json['customer_zipcode'] as num;
    departmentId = json['department_id'] as num;
    latitude = json['latitude'] as num;
    longitude = json['longitude'] as num;
    orderCustomerId = json['order_customer_id'];
    orderId = json['order_id'] as num;
    orderItemCardprodId = json['order_item_cardprod_id'] as num;
    orderItemDiscount = json['order_item_discount'] as num;
    orderItemDiscountRate = json['order_item_discount_rate'] as num;
    orderItemId = json['order_item_id'] as num;
    orderItemProductPrice = json['order_item_product_price'] as num;
    orderItemProfitRatio = json['order_item_profit_ratio'] as num;
    orderItemQuantity = json['order_item_quantity'] as num;
    sales = json['sales'] as num;
    orderItemTotal = json['order_item_total'] as num;
    orderProfitPerOrder = json['order_profit_per_order'] as num;
    productCardId = json['product_card_id'] as num;
    productCategoryId = json['product_category_id'] as num;
    productPrice = json['product_price'] as num;
    productStatus = json['product_status'] as num;
    shippingMode = json['shipping_mode'];
    fraud = json['fraud'] as num;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transfer_type'] = transferType;
    _data['days_for_shipping_real'] = daysForShippingReal;
    _data['days_for_shipment_scheduled'] = daysForShipmentScheduled;
    _data['benefit_per_order'] = benefitPerOrder;
    _data['sales_per_customer'] = salesPerCustomer;
    _data['delivery_status'] = deliveryStatus;
    _data['late_delivery_risk'] = lateDeliveryRisk;
    _data['category_id'] = categoryId;
    _data['customer_id'] = customerId;
    _data['customer_segment'] = customerSegment;
    _data['customer_zipcode'] = customerZipcode;
    _data['department_id'] = departmentId;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['order_customer_id'] = orderCustomerId;
    _data['order_id'] = orderId;
    _data['order_item_cardprod_id'] = orderItemCardprodId;
    _data['order_item_discount'] = orderItemDiscount;
    _data['order_item_discount_rate'] = orderItemDiscountRate;
    _data['order_item_id'] = orderItemId;
    _data['order_item_product_price'] = orderItemProductPrice;
    _data['order_item_profit_ratio'] = orderItemProfitRatio;
    _data['order_item_quantity'] = orderItemQuantity;
    _data['sales'] = sales;
    _data['order_item_total'] = orderItemTotal;
    _data['order_profit_per_order'] = orderProfitPerOrder;
    _data['product_card_id'] = productCardId;
    _data['product_category_id'] = productCategoryId;
    _data['product_price'] = productPrice;
    _data['product_status'] = productStatus;
    _data['shipping_mode'] = shippingMode;
    _data['fraud'] = fraud;
    return _data;
  }
}
