class UserProfileModel {
  bool? succeeded;
  String? message;
  Null? messageCode;
  int? responseCode;
  Null? validationIssue;
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
    data['succeeded'] = this.succeeded;
    data['message'] = this.message;
    data['messageCode'] = this.messageCode;
    data['responseCode'] = this.responseCode;
    data['validationIssue'] = this.validationIssue;
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
  Null? logoImgId;
  Null? licenseImgId;
  Null? commercialRecordImgId;

  Data(
      {this.id,
      this.fullName,
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
      this.commercialRecordImgId});

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
    commercialRecordImgId = json['commercialRecordImgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['arFullName'] = this.arFullName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['license'] = this.license;
    data['commercialRecord'] = this.commercialRecord;
    data['userTypeId'] = this.userTypeId;
    data['userTypeStr'] = this.userTypeStr;
    data['statusId'] = this.statusId;
    data['statusStr'] = this.statusStr;
    data['logoImgId'] = this.logoImgId;
    data['licenseImgId'] = this.licenseImgId;
    data['commercialRecordImgId'] = this.commercialRecordImgId;
    return data;
  }
}
