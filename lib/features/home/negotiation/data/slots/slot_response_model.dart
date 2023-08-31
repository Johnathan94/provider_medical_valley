class SlotResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  List<String>? data;

  SlotResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  SlotResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? (json['data'] as List).cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    return data;
  }
}

class Data {
  int? id;
  int? dayId;
  String? dayName;
  int? providerServiceId;
  int? serviceMaxCountInDay;
  String? slotStartTime;
  String? slotEndTime;
  List<Periods>? periods;

  Data(
      {this.id,
      this.dayId,
      this.dayName,
      this.providerServiceId,
      this.serviceMaxCountInDay,
      this.slotStartTime,
      this.slotEndTime,
      this.periods});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayId = json['dayId'];
    dayName = json['dayName'];
    providerServiceId = json['providerServiceId'];
    serviceMaxCountInDay = json['serviceMaxCountInDay'];
    slotStartTime = json['slotStartTime'];
    slotEndTime = json['slotEndTime'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(Periods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['dayId'] = dayId;
    data['dayName'] = dayName;
    data['providerServiceId'] = providerServiceId;
    data['serviceMaxCountInDay'] = serviceMaxCountInDay;
    data['slotStartTime'] = slotStartTime;
    data['slotEndTime'] = slotEndTime;
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Periods {
  int? id;
  String? from;
  String? to;
  int? providerServiceDaySlotId;

  Periods({this.id, this.from, this.to, this.providerServiceDaySlotId});

  Periods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    providerServiceDaySlotId = json['providerServiceDaySlotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['providerServiceDaySlotId'] = providerServiceDaySlotId;
    return data;
  }
}
