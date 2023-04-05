class UserProfileModel {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  UserProfileModel(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? id;
  String? fullName;
  Null? arFullName;
  String? email;
  String? mobile;
  String? license;
  String? commercialRecord;
  int? userTypeId;
  String? userTypeStr;
  int? statusId;
  String? statusStr;
  String? logoImgId;
  String? licenseImgId;
  String? commercialRecordImgId;
  List<String>? providerBranches;
  int? providerRequestsCount ;
  int? providerRating;

  Data(
      {this.id,
      this.fullName,
      this.providerBranches,
      this.providerRequestsCount,
      this.providerRating,
      this.arFullName,
      this.email,
      this.mobile,
      this.license,
      this.commercialRecord,
      this.userTypeId,
      this.userTypeStr,
      this.statusId,
      this.statusStr,
      this.logoImgId,
      this.licenseImgId,
      this.commercialRecordImgId
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    arFullName = json['arFullName'];
    email = json['email'];
    mobile = json['mobile'];
    license = json['license'];
    commercialRecord = json['commercialRecord'];
    userTypeId = json['userTypeId'];
    userTypeStr = json['userTypeStr'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    logoImgId = json['logoImgId'];
    licenseImgId = json['licenseImgId'];
    providerBranches = json['providerBranches'];
    commercialRecordImgId = json['commercialRecordImgId'];
    providerRequestsCount = json['providerRequestsCount'];
    providerRating = json['providerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['fullName'] = fullName;
    data['arFullName'] = arFullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['license'] = license;
    data['commercialRecord'] = commercialRecord;
    data['userTypeId'] = userTypeId;
    data['userTypeStr'] = userTypeStr;
    data['statusId'] = statusId;
    data['statusStr'] = statusStr;
    data['logoImgId'] = logoImgId;
    data['licenseImgId'] = licenseImgId;
    data['commercialRecordImgId'] = commercialRecordImgId;
    data['providerBranches'] = providerBranches;
    data['providerRequestsCount'] = providerRequestsCount;
    data['providerRating'] = providerRating;
    return data;
  }
}
