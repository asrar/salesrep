class NewOrderDetailModel {
  String id;
  String userId;
  String requestDetialsId;
  String orderAmount;
  String couponDiscountAmount;
  Null couponDiscountTitle;
  String paymentStatus;
  String orderStatus;
  String totalTaxAmount;
  String paymentMethod;
  String transactionReference;
  String deliveryAddressId;
  String deliveryManId;
  Null couponCode;
  String orderNote;
  String orderType;
  String checked;
  Null restaurantId;
  String createdAt;
  String updatedAt;
  String deliveryCharge;
  Null scheduleAt;
  Null callback;
  Null otp;
  String pending;
  Null accepted;
  String confirmed;
  Null processing;
  Null handover;
  String pickedUp;
  String delivered;
  String canceled;
  Null refundRequested;
  Null refunded;
  Null deliveryAddress;
  String scheduled;
  Null restaurantDiscountAmount;
  String originalDeliveryCharge;
  Null failed;
  String adjusment;
  String edited;
  String zoneId;
  String fName;
  String phone;

  NewOrderDetailModel(
      {this.id,
        this.userId,
        this.requestDetialsId,
        this.orderAmount,
        this.couponDiscountAmount,
        this.couponDiscountTitle,
        this.paymentStatus,
        this.orderStatus,
        this.totalTaxAmount,
        this.paymentMethod,
        this.transactionReference,
        this.deliveryAddressId,
        this.deliveryManId,
        this.couponCode,
        this.orderNote,
        this.orderType,
        this.checked,
        this.restaurantId,
        this.createdAt,
        this.updatedAt,
        this.deliveryCharge,
        this.scheduleAt,
        this.callback,
        this.otp,
        this.pending,
        this.accepted,
        this.confirmed,
        this.processing,
        this.handover,
        this.pickedUp,
        this.delivered,
        this.canceled,
        this.refundRequested,
        this.refunded,
        this.deliveryAddress,
        this.scheduled,
        this.restaurantDiscountAmount,
        this.originalDeliveryCharge,
        this.failed,
        this.adjusment,
        this.edited,
        this.zoneId,
        this.fName,
        this.phone});

  NewOrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requestDetialsId = json['request_detials_id'];
    orderAmount = json['order_amount'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryManId = json['delivery_man_id'];
    couponCode = json['coupon_code'];
    orderNote = json['order_note'];
    orderType = json['order_type'];
    checked = json['checked'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge'];
    scheduleAt = json['schedule_at'];
    callback = json['callback'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    deliveryAddress = json['delivery_address'];
    scheduled = json['scheduled'];
    restaurantDiscountAmount = json['restaurant_discount_amount'];
    originalDeliveryCharge = json['original_delivery_charge'];
    failed = json['failed'];
    adjusment = json['adjusment'];
    edited = json['edited'];
    zoneId = json['zone_id'];
    fName = json['f_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['request_detials_id'] = this.requestDetialsId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['delivery_man_id'] = this.deliveryManId;
    data['coupon_code'] = this.couponCode;
    data['order_note'] = this.orderNote;
    data['order_type'] = this.orderType;
    data['checked'] = this.checked;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['callback'] = this.callback;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    data['delivery_address'] = this.deliveryAddress;
    data['scheduled'] = this.scheduled;
    data['restaurant_discount_amount'] = this.restaurantDiscountAmount;
    data['original_delivery_charge'] = this.originalDeliveryCharge;
    data['failed'] = this.failed;
    data['adjusment'] = this.adjusment;
    data['edited'] = this.edited;
    data['zone_id'] = this.zoneId;
    data['f_name'] = this.fName;
    data['phone'] = this.phone;
    return data;
  }
}
