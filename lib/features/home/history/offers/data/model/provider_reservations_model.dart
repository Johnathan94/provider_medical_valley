import 'dart:convert';
/// succeeded : true
/// message : "Request Success"
/// messageCode : null
/// responseCode : 200
/// validationIssue : null
/// data : {"currentPage":1,"totalPages":1,"pageSize":10,"totalCount":1,"hasPrevious":false,"hasNext":false,"results":[{"id":31,"requestId":163,"providerId":85,"providerName":"Wareed Med Labs","providerMobileStr":"0556533578","branchId":8,"providerLocation":"Riyadh","providerLatitude":30.021214,"providerLongitude":30.021214,"providerBranchName":"Jtest","price":500,"isUnderNegotiation":true,"isConfirmed":true,"periodId":139,"periodStartTime":"15:15","periodEndTime":"15:45","offerDate":null,"categoryId":6,"categoryStr":"laboratory","providerServiceId":287,"serviceStr":"Calcium in Serum ","providerPackageId":null,"packageStr":"","userId":48,"userName":"insurance user","userMobile":"147852369","userHasInsurance":true,"bookingStatusId":2,"bookingStatusStr":"Booked","bookingTypeId":1,"bookingTypeStr":"Emmdiate(0-3 H)","insuranceStatus":0,"insuranceStatusStr":"InsuranceNotAvailable"}]}

ProviderNegotiationsModel providerReservationsModelFromJson(String str) => ProviderNegotiationsModel.fromJson(json.decode(str));
String providerReservationsModelToJson(ProviderNegotiationsModel data) => json.encode(data.toJson());
class ProviderNegotiationsModel {
  ProviderNegotiationsModel({
      this.succeeded, 
      this.message, 
      this.messageCode, 
      this.responseCode, 
      this.validationIssue, 
      this.data,});

  ProviderNegotiationsModel.fromJson(dynamic json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? succeeded;
  String? message;
  dynamic messageCode;
  num? responseCode;
  dynamic validationIssue;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['succeeded'] = succeeded;
    map['message'] = message;
    map['messageCode'] = messageCode;
    map['responseCode'] = responseCode;
    map['validationIssue'] = validationIssue;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// currentPage : 1
/// totalPages : 1
/// pageSize : 10
/// totalCount : 1
/// hasPrevious : false
/// hasNext : false
/// results : [{"id":31,"requestId":163,"providerId":85,"providerName":"Wareed Med Labs","providerMobileStr":"0556533578","branchId":8,"providerLocation":"Riyadh","providerLatitude":30.021214,"providerLongitude":30.021214,"providerBranchName":"Jtest","price":500,"isUnderNegotiation":true,"isConfirmed":true,"periodId":139,"periodStartTime":"15:15","periodEndTime":"15:45","offerDate":null,"categoryId":6,"categoryStr":"laboratory","providerServiceId":287,"serviceStr":"Calcium in Serum ","providerPackageId":null,"packageStr":"","userId":48,"userName":"insurance user","userMobile":"147852369","userHasInsurance":true,"bookingStatusId":2,"bookingStatusStr":"Booked","bookingTypeId":1,"bookingTypeStr":"Emmdiate(0-3 H)","insuranceStatus":0,"insuranceStatusStr":"InsuranceNotAvailable"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.currentPage, 
      this.totalPages, 
      this.pageSize, 
      this.totalCount, 
      this.hasPrevious, 
      this.hasNext, 
      this.results,});

  Data.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    hasPrevious = json['hasPrevious'];
    hasNext = json['hasNext'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  num? currentPage;
  num? totalPages;
  num? pageSize;
  num? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    map['pageSize'] = pageSize;
    map['totalCount'] = totalCount;
    map['hasPrevious'] = hasPrevious;
    map['hasNext'] = hasNext;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 31
/// requestId : 163
/// providerId : 85
/// providerName : "Wareed Med Labs"
/// providerMobileStr : "0556533578"
/// branchId : 8
/// providerLocation : "Riyadh"
/// providerLatitude : 30.021214
/// providerLongitude : 30.021214
/// providerBranchName : "Jtest"
/// price : 500
/// isUnderNegotiation : true
/// isConfirmed : true
/// periodId : 139
/// periodStartTime : "15:15"
/// periodEndTime : "15:45"
/// offerDate : null
/// categoryId : 6
/// categoryStr : "laboratory"
/// providerServiceId : 287
/// serviceStr : "Calcium in Serum "
/// providerPackageId : null
/// packageStr : ""
/// userId : 48
/// userName : "insurance user"
/// userMobile : "147852369"
/// userHasInsurance : true
/// bookingStatusId : 2
/// bookingStatusStr : "Booked"
/// bookingTypeId : 1
/// bookingTypeStr : "Emmdiate(0-3 H)"
/// insuranceStatus : 0
/// insuranceStatusStr : "InsuranceNotAvailable"

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      this.id, 
      this.requestId, 
      this.providerId, 
      this.providerName, 
      this.providerMobileStr, 
      this.branchId, 
      this.providerLocation, 
      this.providerLatitude, 
      this.providerLongitude, 
      this.providerBranchName, 
      this.price, 
      this.isUnderNegotiation, 
      this.isConfirmed, 
      this.periodId, 
      this.periodStartTime, 
      this.periodEndTime, 
      this.offerDate, 
      this.categoryId, 
      this.categoryStr, 
      this.providerServiceId, 
      this.serviceStr, 
      this.providerPackageId, 
      this.packageStr, 
      this.userId, 
      this.userName, 
      this.userMobile, 
      this.userHasInsurance, 
      this.bookingStatusId, 
      this.bookingStatusStr, 
      this.bookingTypeId, 
      this.bookingTypeStr, 
      this.insuranceStatus, 
      this.image,
      this.insuranceStatusStr,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['requestId'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerMobileStr = json['providerMobileStr'];
    branchId = json['branchId'];
    providerLocation = json['providerLocation'];
    providerLatitude = json['providerLatitude'];
    providerLongitude = json['providerLongitude'];
    providerBranchName = json['providerBranchName'];
    price = json['price'];
    isUnderNegotiation = json['isUnderNegotiation'];
    isConfirmed = json['isConfirmed'];
    periodId = json['periodId'];
    periodStartTime = json['periodStartTime'];
    periodEndTime = json['periodEndTime'];
    offerDate = json['offerDate'];
    categoryId = json['categoryId'];
    categoryStr = json['categoryStr'];
    providerServiceId = json['providerServiceId'];
    serviceStr = json['serviceStr'];
    providerPackageId = json['providerPackageId'];
    packageStr = json['packageStr'];
    userId = json['userId'];
    userName = json['userName'];
    userMobile = json['userMobile'];
    userHasInsurance = json['userHasInsurance'];
    bookingStatusId = json['bookingStatusId'];
    bookingStatusStr = json['bookingStatusStr'];
    bookingTypeId = json['bookingTypeId'];
    bookingTypeStr = json['bookingTypeStr'];
    insuranceStatus = json['insuranceStatus'];
    insuranceStatusStr = json['insuranceStatusStr'];
    image = json['userAvatar'];
  }
  num? id;
  num? requestId;
  num? providerId;
  String? providerName;
  String? providerMobileStr;
  num? branchId;
  String? providerLocation;
  num? providerLatitude;
  num? providerLongitude;
  String? providerBranchName;
  num? price;
  bool? isUnderNegotiation;
  bool? isConfirmed;
  num? periodId;
  String? periodStartTime;
  String? periodEndTime;
  dynamic offerDate;
  num? categoryId;
  String? categoryStr;
  num? providerServiceId;
  String? serviceStr;
  dynamic providerPackageId;
  String? packageStr;
  num? userId;
  String? userName;
  String? userMobile;
  bool? userHasInsurance;
  num? bookingStatusId;
  String? bookingStatusStr;
  num? bookingTypeId;
  String? bookingTypeStr;
  num? insuranceStatus;
  String? insuranceStatusStr;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['requestId'] = requestId;
    map['providerId'] = providerId;
    map['providerName'] = providerName;
    map['providerMobileStr'] = providerMobileStr;
    map['branchId'] = branchId;
    map['providerLocation'] = providerLocation;
    map['providerLatitude'] = providerLatitude;
    map['providerLongitude'] = providerLongitude;
    map['providerBranchName'] = providerBranchName;
    map['price'] = price;
    map['isUnderNegotiation'] = isUnderNegotiation;
    map['isConfirmed'] = isConfirmed;
    map['periodId'] = periodId;
    map['periodStartTime'] = periodStartTime;
    map['periodEndTime'] = periodEndTime;
    map['offerDate'] = offerDate;
    map['categoryId'] = categoryId;
    map['categoryStr'] = categoryStr;
    map['providerServiceId'] = providerServiceId;
    map['serviceStr'] = serviceStr;
    map['providerPackageId'] = providerPackageId;
    map['packageStr'] = packageStr;
    map['userId'] = userId;
    map['userName'] = userName;
    map['userMobile'] = userMobile;
    map['userHasInsurance'] = userHasInsurance;
    map['bookingStatusId'] = bookingStatusId;
    map['bookingStatusStr'] = bookingStatusStr;
    map['bookingTypeId'] = bookingTypeId;
    map['bookingTypeStr'] = bookingTypeStr;
    map['insuranceStatus'] = insuranceStatus;
    map['insuranceStatusStr'] = insuranceStatusStr;
    map['userAvatar'] = image;
    return map;
  }

}