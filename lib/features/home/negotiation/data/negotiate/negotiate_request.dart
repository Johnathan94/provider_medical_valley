class NegotiateRequest {
  int? negotiateId;
  int? price;
  Time? time;

  NegotiateRequest({this.negotiateId, this.price, this.time});

  NegotiateRequest.fromJson(Map<String, dynamic> json) {
    negotiateId = json['negotiateId'];
    price = json['price'];
    time = json['time'] != null ?  Time.fromJson(json['time']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['negotiateId'] = negotiateId;
    data['price'] = price;
    if (time != null) {
      data['time'] = time!.toJson();
    }
    return data;
  }
}

class Time {
  int? ticks;
  int? days;
  int? hours;
  int? milliseconds;
  int? minutes;
  int? seconds;

  Time(
      {this.ticks,
        this.days,
        this.hours,
        this.milliseconds,
        this.minutes,
        this.seconds});

  Time.fromJson(Map<String, dynamic> json) {
    ticks = json['ticks'];
    days = json['days'];
    hours = json['hours'];
    milliseconds = json['milliseconds'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['ticks'] = ticks;
    data['days'] = days;
    data['hours'] = hours;
    data['milliseconds'] = milliseconds;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    return data;
  }
}
