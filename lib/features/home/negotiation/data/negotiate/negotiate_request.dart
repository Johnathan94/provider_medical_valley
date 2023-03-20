class NegotiationRequest {
  int? negotiateId;
  int? price;
  int? periodId;

  NegotiationRequest({this.negotiateId, this.price, this.periodId});

  NegotiationRequest.fromJson(Map<String, dynamic> json) {
    negotiateId = json['negotiateId'];
    price = json['price'];
    periodId = json['periodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['negotiateId'] = negotiateId;
    data['price'] = price;
    data['periodId'] = periodId;
    return data;
  }
}
