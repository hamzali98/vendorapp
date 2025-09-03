class LaundroyProductModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Products>? products;

  LaundroyProductModel(
      {this.responseCode, this.result, this.responseMsg, this.products});

  LaundroyProductModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productEntryId;
  String? laundromatId;
  String? productId;
  String? basePrice;
  String? appPrice;
  String? productName;

  Products(
      {this.productEntryId,
        this.laundromatId,
        this.productId,
        this.basePrice,
        this.appPrice,
        this.productName});

  Products.fromJson(Map<String, dynamic> json) {
    productEntryId = json['product_entry_id'];
    laundromatId = json['laundromat_id'];
    productId = json['product_id'];
    basePrice = json['base_price'];
    appPrice = json['app_price'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_entry_id'] = this.productEntryId;
    data['laundromat_id'] = this.laundromatId;
    data['product_id'] = this.productId;
    data['base_price'] = this.basePrice;
    data['app_price'] = this.appPrice;
    data['product_name'] = this.productName;
    return data;
  }
}
