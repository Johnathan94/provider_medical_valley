class ServicesResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  List<ServiceModel>? results;

  ServicesResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.results});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    if (json['data'] != null) {
      results = <ServiceModel>[];
      json['data'].forEach((v) {
        results!.add(ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;

    return data;
  }
}

class ServiceModel {
  int? serviceId;
  String? englishName;
  String? arabicName;
  int? statusId;
  int? categoryId;
  bool? isActive;

  ServiceModel(
      {this.serviceId,
      this.englishName,
      this.arabicName,
      this.statusId,
      this.categoryId,
      this.isActive});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    statusId = json['statusId'];
    categoryId = json['categoryId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['serviceId'] = serviceId;
    data['englishName'] = englishName;
    data['arabicName'] = arabicName;
    data['statusId'] = statusId;
    data['categoryId'] = categoryId;
    data['isActive'] = isActive;
    return data;
  }
}
