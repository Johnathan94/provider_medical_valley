class SlotResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  SlotData? data;

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
    data = json['data'] != null ?  SlotData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SlotData {
  List<ServiceDays>? serviceDays;

  SlotData({this.serviceDays});

  SlotData.fromJson(Map<String, dynamic> json) {
    if (json['serviceDays'] != null) {
      serviceDays = <ServiceDays>[];
      json['serviceDays'].forEach((v) {
        serviceDays!.add( ServiceDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    if (serviceDays != null) {
      data['serviceDays'] = serviceDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceDays {
  int? dayId;
  int? serviceId;
  String? dayName;
  int? serviceMaxCountInDay;
  String? slotStartTime;
  String? slotEndTime;

  ServiceDays(
      {this.dayId,
        this.serviceId,
        this.dayName,
        this.serviceMaxCountInDay,
        this.slotStartTime,
        this.slotEndTime});

  ServiceDays.fromJson(Map<String, dynamic> json) {
    dayId = json['dayId'];
    serviceId = json['serviceId'];
    dayName = json['dayName'];
    serviceMaxCountInDay = json['serviceMaxCountInDay'];
    slotStartTime = json['slotStartTime'];
    slotEndTime = json['slotEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['dayId'] = dayId;
    data['serviceId'] = serviceId;
    data['dayName'] = dayName;
    data['serviceMaxCountInDay'] = serviceMaxCountInDay;
    data['slotStartTime'] = slotStartTime;
    data['slotEndTime'] = slotEndTime;
    return data;
  }
}
