class NegotiationRequest {
  int? negotiateId;
  int? price;
  String? startTime;

  NegotiationRequest({this.negotiateId, this.price, this.startTime});

  NegotiationRequest.fromJson(Map<String, dynamic> json) {
    negotiateId = json['negotiateId'];
    price = json['price'];
    startTime = json['periodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['negotiateId'] = negotiateId;
    data['price'] = price;
    data['periodId'] = startTime;
    return data;
  }
}
