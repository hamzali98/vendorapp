class UpadateTillIdOderModel {
  String? responseCode;
  String? result;
  String? title;
  int? orderId;
  String? orderType;

  UpadateTillIdOderModel(
      {this.responseCode,
        this.result,
        this.title,
        this.orderId,
        this.orderType});

  UpadateTillIdOderModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    title = json['title'];
    orderId = json['order_id'];
    orderType = json['order_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['title'] = this.title;
    data['order_id'] = this.orderId;
    data['order_type'] = this.orderType;
    return data;
  }
}
