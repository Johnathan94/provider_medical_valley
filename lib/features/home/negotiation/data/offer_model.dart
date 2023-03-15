class SendOffer {
  int? id;
  int? requestId;
  int? userId;
  int? price;
  SlotStartTime? slotStartTime;

  SendOffer(
      {this.id, this.requestId, this.userId, this.price, this.slotStartTime});

  SendOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    userId = json['userId'];
    price = json['price'];
    slotStartTime = json['slotStartTime'] != null
        ?  SlotStartTime.fromJson(json['slotStartTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['requestId'] = requestId;
    data['userId'] = userId;
    data['price'] = price;
    if (slotStartTime != null) {
      data['slotStartTime'] = slotStartTime!.toJson();
    }
    return data;
  }
}

class SlotStartTime {
  int? ticks;
  int? days;
  int? hours;
  int? milliseconds;
  int? minutes;
  int? seconds;

  SlotStartTime(
      {this.ticks,
        this.days,
        this.hours,
        this.milliseconds,
        this.minutes,
        this.seconds});

  SlotStartTime.fromJson(Map<String, dynamic> json) {
    ticks = json['ticks'];
    days = json['days'];
    hours = json['hours'];
    milliseconds = json['milliseconds'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ticks'] = ticks;
    data['days'] = days;
    data['hours'] = hours;
    data['milliseconds'] = milliseconds;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    return data;
  }
}
