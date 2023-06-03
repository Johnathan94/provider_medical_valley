class RequestsResponse {
  bool? succeeded;
  String? message;
  int? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  RequestsResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  RequestsResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  List<BookRequest>? results;

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
      results = <BookRequest>[];
      json['results'].forEach((v) {
        results!.add(BookRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class BookRequest {
  int? id;
  int? providerServiceId;
  int? userId;
  String? userStr;
  String? categoryStr;
  String? serviceStr;
  String? bookingTypeStr;
  String? mobileStr;
  bool? userHasInsurance;

  BookRequest(
      {this.id,
      this.userId,
      this.userStr,
      this.categoryStr,
      this.providerServiceId,
      this.serviceStr,
      this.bookingTypeStr,
      this.mobileStr,
      this.userHasInsurance});

  BookRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userStr = json['userName'];
    categoryStr = json['categoryStr'];
    serviceStr = json['providerServiceName'];
    bookingTypeStr = json['bookingTypeStr'];
    mobileStr = json['mobileStr'];
    userHasInsurance = json['userHasInsurance'];
    providerServiceId = json['providerServiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['userStr'] = userStr;
    data['categoryStr'] = categoryStr;
    data['serviceStr'] = serviceStr;
    data['bookingTypeStr'] = bookingTypeStr;
    data['mobileStr'] = mobileStr;
    data['haveInsurance'] = userHasInsurance;
    data['providerServiceId'] = providerServiceId;
    return data;
  }
}
