class SendOffer {
  int? id;
  int? requestId;
  int? userId;
  int? price;
  int? periodId;

  SendOffer({this.id, this.requestId, this.userId, this.price, this.periodId});

  SendOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    userId = json['userId'];
    price = json['price'];
    periodId = json['periodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['userId'] = userId;
    data['price'] = price;
    data['periodId'] = periodId;
    return data;
  }
}
