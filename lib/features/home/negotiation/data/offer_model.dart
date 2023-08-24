class SendOffer {
  int? requestId;
  int? providerId;
  double? price;
  int? periodId;
  int? branchId;
  int? insuranceStatus;

  SendOffer(
      {this.requestId,
      this.providerId,
      this.price,
      this.periodId,
      this.insuranceStatus,
      this.branchId});

  SendOffer.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    providerId = json['providerId'];
    price = json['price'];
    periodId = json['periodId'];
    branchId = json['branchId'];
    insuranceStatus = json['insuranceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['requestId'] = requestId;
    data['providerId'] = providerId;
    data['price'] = price;
    data['periodId'] = periodId;
    data['branchId'] = branchId;
    data['insuranceStatus'] = insuranceStatus;
    return data;
  }
}
