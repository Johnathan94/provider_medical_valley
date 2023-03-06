class SendOffer {
  int? id;
  int? requestId;
  int? userId;
  int? price;

  SendOffer({this.id, this.requestId, this.userId, this.price});

  SendOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    userId = json['userId'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['requestId'] = this.requestId;
    data['userId'] = this.userId;
    data['price'] = this.price;
    return data;
  }
}
