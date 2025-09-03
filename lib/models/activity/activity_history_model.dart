class ActivityOrdersHistoryModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Orders>? orders;
  Pagination? pagination;

  ActivityOrdersHistoryModel(
      {this.responseCode,
        this.result,
        this.responseMsg,
        this.orders,
        this.pagination});

  ActivityOrdersHistoryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['Orders'] != null) {
      orders = <Orders>[];
      json['Orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    pagination = json['Pagination'] != null
        ? new Pagination.fromJson(json['Pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    if (this.orders != null) {
      data['Orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['Pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  String? orderType;
  String? orderStatus;
  String? orderPrice;
  String? totalBags;
  String? weight;
  String? createdAt;
  List<Products>? products;
  Customer? customer;

  Orders(
      {this.orderId,
        this.orderType,
        this.orderStatus,
        this.orderPrice,
        this.totalBags,
        this.weight,
        this.createdAt,
        this.products,
        this.customer});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    orderPrice = json['order_price'];
    totalBags = json['total_bags'];
    weight = json['weight'];
    createdAt = json['created_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_type'] = this.orderType;
    data['order_status'] = this.orderStatus;
    data['order_price'] = this.orderPrice;
    data['total_bags'] = this.totalBags;
    data['weight'] = this.weight;
    data['created_at'] = this.createdAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Products {
  String? productName;
  String? variationName;
  int? quantity;
  int? price;

  Products({this.productName, this.variationName, this.quantity, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    variationName = json['variation_name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['variation_name'] = this.variationName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}

class Customer {
  String? name;
  String? email;
  String? mobile;

  Customer({this.name, this.email, this.mobile});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalOrders;

  Pagination({this.currentPage, this.totalPages, this.totalOrders});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}
