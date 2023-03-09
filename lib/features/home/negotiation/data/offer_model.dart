class SendOffer {
  int? id;
  int? requestId;
  int? userId;
  int? price;
  String? slot;

  SendOffer({this.id, this.requestId, this.userId, this.price, this.slot});

  SendOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    userId = json['userId'];
    price = json['price'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['userId'] = userId;
    data['price'] = price;
    data['slot'] = slot;
    return data;
  }
}
