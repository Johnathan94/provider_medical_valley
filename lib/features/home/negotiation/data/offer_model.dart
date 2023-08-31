class SendOffer {
  int? requestId;
  int? providerId;
  double? price;
  String? startTime;
  int? branchId;
  int? insuranceStatus;

  SendOffer(
      {this.requestId,
      this.providerId,
      this.price,
      this.startTime,
      this.insuranceStatus,
      this.branchId});

  SendOffer.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    providerId = json['providerId'];
    price = json['price'];
    startTime = json['periodId'];
    branchId = json['branchId'];
    insuranceStatus = json['insuranceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['requestId'] = requestId;
    data['providerId'] = providerId;
    data['price'] = price;
    data['serviceStartTime'] = startTime;
    data['branchId'] = branchId;
    data['insuranceStatus'] = insuranceStatus;
    return data;
  }
}
