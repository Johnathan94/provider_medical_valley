class SendOffer {
  int? id;
  int? requestId;
  int? userId;
  int? price;
  int? periodId;
  int? branchId;
  int? insuranceStatus;

  SendOffer(
      {this.id,
      this.requestId,
      this.userId,
      this.price,
      this.periodId,
      this.insuranceStatus,
      this.branchId});

  SendOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    userId = json['userId'];
    price = json['price'];
    periodId = json['periodId'];
    branchId = json['branchId'];
    insuranceStatus = json['insuranceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['userId'] = userId;
    data['price'] = price;
    data['periodId'] = periodId;
    data['branchId'] = branchId;
    data['insuranceStatus'] = insuranceStatus;
    return data;
  }
}
