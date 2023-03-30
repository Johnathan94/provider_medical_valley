
class ServicesResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  ServicesResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
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

class Data {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<ServiceModel>? results;

  Data(
      {this.currentPage,
        this.totalPages,
        this.pageSize,
        this.totalCount,
        this.hasPrevious,
        this.hasNext,
        this.results});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    hasPrevious = json['hasPrevious'];
    hasNext = json['hasNext'];
    if (json['results'] != null) {
      results = <ServiceModel>[];
      json['results'].forEach((v) {
        results!.add( ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['pageSize'] = pageSize;
    data['totalCount'] = totalCount;
    data['hasPrevious'] = hasPrevious;
    data['hasNext'] = hasNext;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceModel {
  int? serviceId;
  String? serviceName;
  String? categoryName;
  String? dateFrom;
  String? dateTo;
  String? statusStr;
  bool? autoReply;
  bool? isActive;

  ServiceModel(
      {this.serviceId,
        this.serviceName,
        this.categoryName,
        this.dateFrom,
        this.dateTo,
        this.statusStr,
        this.autoReply,
        this.isActive});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    categoryName = json['categoryName'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    statusStr = json['statusStr'];
    autoReply = json['autoReply'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    data['categoryName'] = categoryName;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['statusStr'] = statusStr;
    data['autoReply'] = autoReply;
    data['isActive'] = isActive;
    return data;
  }
}
