class GenerateReceiptModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  OrderDetails? orderDetails;
  CustomerDetails? customerDetails;
  LaundromatDetails? laundromatDetails;

  GenerateReceiptModel(
      {this.responseCode,
        this.result,
        this.responseMsg,
        this.orderDetails,
        this.customerDetails,
        this.laundromatDetails});

  GenerateReceiptModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    orderDetails = json['OrderDetails'] != null
        ? new OrderDetails.fromJson(json['OrderDetails'])
        : null;
    customerDetails = json['CustomerDetails'] != null
        ? new CustomerDetails.fromJson(json['CustomerDetails'])
        : null;
    laundromatDetails = json['LaundromatDetails'] != null
        ? new LaundromatDetails.fromJson(json['LaundromatDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    if (this.orderDetails != null) {
      data['OrderDetails'] = this.orderDetails!.toJson();
    }
    if (this.customerDetails != null) {
      data['CustomerDetails'] = this.customerDetails!.toJson();
    }
    if (this.laundromatDetails != null) {
      data['LaundromatDetails'] = this.laundromatDetails!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  String? orderQId;
  int? customerId;
  int? laundromatId;
  String? orderTime;
  String? orderDate;
  String? orderType;
  String? orderStatus;
  Null? driverAssignedId;
  String? orderPrice;
  Null? receipt;
  Null? rating;
  Null? attachment;
  Null? deliveryCode;
  Null? productType;
  String? createdAt;
  String? totalBags;
  String? weight;
  String? pickupOrderTime;
  String? deliveryMethod;
  String? deliveryType;
  String? orderInstructions;
  String? orderAddress;
  Null? status;
  String? payment;
  String? productDetails;
  String? orderTemp;
  String? houseStatus;
  String? aptNo;
  String? elevatorStatus;
  String? floor;
  String? deliveryStatus;
  Null? helpStatus;
  Null? confirmOrderPic;
  String? dueTo;
  String? deliveryTime;
  Null? collectedAmount;
  String? paymentStatus;
  Null? paymentType;
  String? laundromatName;
  String? customerName;
  String? customerMobile;

  OrderDetails(
      {this.id,
        this.orderQId,
        this.customerId,
        this.laundromatId,
        this.orderTime,
        this.orderDate,
        this.orderType,
        this.orderStatus,
        this.driverAssignedId,
        this.orderPrice,
        this.receipt,
        this.rating,
        this.attachment,
        this.deliveryCode,
        this.productType,
        this.createdAt,
        this.totalBags,
        this.weight,
        this.pickupOrderTime,
        this.deliveryMethod,
        this.deliveryType,
        this.orderInstructions,
        this.orderAddress,
        this.status,
        this.payment,
        this.productDetails,
        this.orderTemp,
        this.houseStatus,
        this.aptNo,
        this.elevatorStatus,
        this.floor,
        this.deliveryStatus,
        this.helpStatus,
        this.confirmOrderPic,
        this.dueTo,
        this.deliveryTime,
        this.collectedAmount,
        this.paymentStatus,
        this.paymentType,
        this.laundromatName,
        this.customerName,
        this.customerMobile});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderQId = json['order_q_id'];
    customerId = json['customer_id'];
    laundromatId = json['laundromat_id'];
    orderTime = json['order_time'];
    orderDate = json['order_date'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    driverAssignedId = json['driver_assigned_id'];
    orderPrice = json['order_price'];
    receipt = json['receipt'];
    rating = json['rating'];
    attachment = json['attachment'];
    deliveryCode = json['delivery_code'];
    productType = json['product_type'];
    createdAt = json['created_at'];
    totalBags = json['total_bags'];
    weight = json['weight'];
    pickupOrderTime = json['pickup_order_time'];
    deliveryMethod = json['delivery_method'];
    deliveryType = json['delivery_type'];
    orderInstructions = json['order_instructions'];
    orderAddress = json['order_address'];
    status = json['status'];
    payment = json['payment'];
    productDetails = json['product_details'];
    orderTemp = json['order_temp'];
    houseStatus = json['house_status'];
    aptNo = json['apt_no'];
    elevatorStatus = json['elevator_status'];
    floor = json['floor'];
    deliveryStatus = json['delivery_status'];
    helpStatus = json['help_status'];
    confirmOrderPic = json['confirm_order_pic'];
    dueTo = json['due_to'];
    deliveryTime = json['delivery_time'];
    collectedAmount = json['collected_amount'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    laundromatName = json['laundromat_name'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_q_id'] = this.orderQId;
    data['customer_id'] = this.customerId;
    data['laundromat_id'] = this.laundromatId;
    data['order_time'] = this.orderTime;
    data['order_date'] = this.orderDate;
    data['order_type'] = this.orderType;
    data['order_status'] = this.orderStatus;
    data['driver_assigned_id'] = this.driverAssignedId;
    data['order_price'] = this.orderPrice;
    data['receipt'] = this.receipt;
    data['rating'] = this.rating;
    data['attachment'] = this.attachment;
    data['delivery_code'] = this.deliveryCode;
    data['product_type'] = this.productType;
    data['created_at'] = this.createdAt;
    data['total_bags'] = this.totalBags;
    data['weight'] = this.weight;
    data['pickup_order_time'] = this.pickupOrderTime;
    data['delivery_method'] = this.deliveryMethod;
    data['delivery_type'] = this.deliveryType;
    data['order_instructions'] = this.orderInstructions;
    data['order_address'] = this.orderAddress;
    data['status'] = this.status;
    data['payment'] = this.payment;
    data['product_details'] = this.productDetails;
    data['order_temp'] = this.orderTemp;
    data['house_status'] = this.houseStatus;
    data['apt_no'] = this.aptNo;
    data['elevator_status'] = this.elevatorStatus;
    data['floor'] = this.floor;
    data['delivery_status'] = this.deliveryStatus;
    data['help_status'] = this.helpStatus;
    data['confirm_order_pic'] = this.confirmOrderPic;
    data['due_to'] = this.dueTo;
    data['delivery_time'] = this.deliveryTime;
    data['collected_amount'] = this.collectedAmount;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['laundromat_name'] = this.laundromatName;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    return data;
  }
}

class CustomerDetails {
  String? name;
  String? mobile;

  CustomerDetails({this.name, this.mobile});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}

class LaundromatDetails {
  String? name;

  LaundromatDetails({this.name});

  LaundromatDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
