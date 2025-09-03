// class PickUpModel {
//   String? responseCode;
//   String? result;
//   String? responseMsg;
//   List<Orders>? orders;
//
//   PickUpModel({this.responseCode, this.result, this.responseMsg, this.orders});
//
//   PickUpModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['ResponseCode'];
//     result = json['Result'];
//     responseMsg = json['ResponseMsg'];
//     if (json['Orders'] != null) {
//       orders = <Orders>[];
//       json['Orders'].forEach((v) {
//         orders!.add(new Orders.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ResponseCode'] = this.responseCode;
//     data['Result'] = this.result;
//     data['ResponseMsg'] = this.responseMsg;
//     if (this.orders != null) {
//       data['Orders'] = this.orders!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Orders {
//   String? id;
//   String? orderQId;
//   String? customerId;
//   String? customerName;
//   String? driverName;
//   Null? stAddress;
//   String? orderTime;
//   String? orderDate;
//   String? orderType;
//   String? orderStatus;
//   String? orderPrice;
//   String? receipt;
//   String? rating;
//   String? attachment;
//   String? deliveryCode;
//   String? productType;
//   String? createdAt;
//   String? weight;
//   String? pickupOrderTime;
//
//   Orders(
//       {this.id,
//         this.orderQId,
//         this.customerId,
//         this.customerName,
//         this.driverName,
//         this.stAddress,
//         this.orderTime,
//         this.orderDate,
//         this.orderType,
//         this.orderStatus,
//         this.orderPrice,
//         this.receipt,
//         this.rating,
//         this.attachment,
//         this.deliveryCode,
//         this.productType,
//         this.createdAt,
//         this.weight,
//         this.pickupOrderTime});
//
//   Orders.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderQId = json['order_q_id'];
//     customerId = json['customer_id'];
//     customerName = json['customer_name'];
//     driverName = json['driver_name'];
//     stAddress = json['st_address'];
//     orderTime = json['order_time'];
//     orderDate = json['order_date'];
//     orderType = json['order_type'];
//     orderStatus = json['order_status'];
//     orderPrice = json['order_price'];
//     receipt = json['receipt'];
//     rating = json['rating'];
//     attachment = json['attachment'];
//     deliveryCode = json['delivery_code'];
//     productType = json['product_type'];
//     createdAt = json['created_at'];
//     weight = json['weight'];
//     pickupOrderTime = json['pickup_order_time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_q_id'] = this.orderQId;
//     data['customer_id'] = this.customerId;
//     data['customer_name'] = this.customerName;
//     data['driver_name'] = this.driverName;
//     data['st_address'] = this.stAddress;
//     data['order_time'] = this.orderTime;
//     data['order_date'] = this.orderDate;
//     data['order_type'] = this.orderType;
//     data['order_status'] = this.orderStatus;
//     data['order_price'] = this.orderPrice;
//     data['receipt'] = this.receipt;
//     data['rating'] = this.rating;
//     data['attachment'] = this.attachment;
//     data['delivery_code'] = this.deliveryCode;
//     data['product_type'] = this.productType;
//     data['created_at'] = this.createdAt;
//     data['weight'] = this.weight;
//     data['pickup_order_time'] = this.pickupOrderTime;
//     return data;
//   }
// }
class PickUpModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Orders>? orders;
  Pagination? pagination;

  PickUpModel({this.responseCode, this.result, this.responseMsg, this.orders, this.pagination});

  PickUpModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'] as String?;
    result = json['Result'] as String?;
    responseMsg = json['ResponseMsg'] as String?;
    if (json['Orders'] != null) {
      orders = (json['Orders'] as List).map((v) => Orders.fromJson(v)).toList();
    }
    pagination = json['Pagination'] != null ? Pagination.fromJson(json['Pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'ResponseCode': responseCode,
      'Result': result,
      'ResponseMsg': responseMsg,
      'Orders': orders?.map((v) => v.toJson()).toList(),
      'Pagination': pagination?.toJson(),
    };
  }
}

class Orders {
  String? id;
  String? orderQId;
  String? customerId;
  String? customerName;
  String? driverName;
  String? stAddress;
  String? orderTime;
  String? orderDate;
  String? orderType;
  String? orderStatus;
  String? orderPrice;
  String? receipt;
  String? rating;
  String? attachment;
  String? deliveryCode;
  String? productType;
  String? createdAt;
  String? weight;
  String? pickupOrderTime;

  Orders({
    this.id,
    this.orderQId,
    this.customerId,
    this.customerName,
    this.driverName,
    this.stAddress,
    this.orderTime,
    this.orderDate,
    this.orderType,
    this.orderStatus,
    this.orderPrice,
    this.receipt,
    this.rating,
    this.attachment,
    this.deliveryCode,
    this.productType,
    this.createdAt,
    this.weight,
    this.pickupOrderTime,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    orderQId = json['order_q_id'] as String?;
    customerId = json['customer_id'] as String?;
    customerName = json['customer_name'] as String?;
    driverName = json['driver_name'] as String?; // Nullable
    stAddress = json['st_address'] as String?; // Nullable
    orderTime = json['order_time'] as String?;
    orderDate = json['order_date'] as String?;
    orderType = json['order_type'] as String?;
    orderStatus = json['order_status'] as String?;
    orderPrice = json['order_price'] as String?;
    receipt = json['receipt'] as String?; // Nullable
    rating = json['rating'] as String?; // Nullable
    attachment = json['attachment'] as String?; // Nullable
    deliveryCode = json['delivery_code'] as String?; // Nullable
    productType = json['product_type'] as String?; // Nullable
    createdAt = json['created_at'] as String?;
    weight = json['weight'] as String?;
    pickupOrderTime = json['pickup_order_time'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_q_id': orderQId,
      'customer_id': customerId,
      'customer_name': customerName,
      'driver_name': driverName,
      'st_address': stAddress,
      'order_time': orderTime,
      'order_date': orderDate,
      'order_type': orderType,
      'order_status': orderStatus,
      'order_price': orderPrice,
      'receipt': receipt,
      'rating': rating,
      'attachment': attachment,
      'delivery_code': deliveryCode,
      'product_type': productType,
      'created_at': createdAt,
      'weight': weight,
      'pickup_order_time': pickupOrderTime,
    };
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? limit;
  int? totalRecords; // Changed from String? to int?

  Pagination({this.currentPage, this.totalPages, this.limit, this.totalRecords});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] as int?;
    totalPages = json['total_pages'] as int?;
    limit = json['limit'] as int?;
    totalRecords = int.tryParse(json['total_records'].toString()); // Convert to int safely
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'limit': limit,
      'total_records': totalRecords.toString(),
    };
  }
}
