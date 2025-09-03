class RegisterCustomerModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  int? userID;

  RegisterCustomerModel(
      {this.responseCode, this.result, this.responseMsg, this.userID});

  RegisterCustomerModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    userID = json['UserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    data['UserID'] = this.userID;
    return data;
  }
}
