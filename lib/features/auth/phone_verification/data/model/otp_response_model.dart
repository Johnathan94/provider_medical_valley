class OtpResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  OtpResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  OtpResponse.fromJson(Map<String, dynamic> json) {
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
  OtpData? otpData;
  String? token;

  Data({this.otpData, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    otpData = json['data'] != null ? OtpData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (otpData != null) {
      data['data'] = otpData!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class OtpData {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  ProviderData? userDate;

  OtpData(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.userDate});

  OtpData.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    userDate =
        json['data'] != null ? ProviderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (userDate != null) {
      data['data'] = userDate!.toJson();
    }
    return data;
  }
}

class ProviderData {
  int? id;
  String? fullName;
  String? arFullName;
  String? email;
  String? mobile;
  String? license;
  String? commercialRecord;
  int? statusId;
  String? statusStr;
  int? logoImgId;
  String? licenseImgId;
  String? commercialRecordImgId;
  List<BranchModel>? providerBranches;
  int? providerRequestsCount;
  double? providerRating;

  ProviderData(
      {this.id,
      this.fullName,
      this.arFullName,
      this.email,
      this.mobile,
      this.license,
      this.commercialRecord,
      this.statusId,
      this.statusStr,
      this.logoImgId,
      this.licenseImgId,
      this.commercialRecordImgId,
      this.providerBranches,
      this.providerRequestsCount,
      this.providerRating});

  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    arFullName = json['arFullName'];
    email = json['email'];
    mobile = json['mobile'];
    license = json['license'];
    commercialRecord = json['commercialRecord'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    logoImgId = json['logoImgId'];
    licenseImgId = json['licenseImgId'];
    commercialRecordImgId = json['commercialRecordImgId'];
    if (json['providerBranches'] != null) {
      providerBranches = <BranchModel>[];
      json['providerBranches'].forEach((v) {
        providerBranches!.add(BranchModel.fromJson(v));
      });
    }
    providerRequestsCount = json['providerRequestsCount'];
    providerRating = json['providerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['fullName'] = fullName;
    data['arFullName'] = arFullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['license'] = license;
    data['commercialRecord'] = commercialRecord;
    data['statusId'] = statusId;
    data['statusStr'] = statusStr;
    data['logoImgId'] = logoImgId;
    data['licenseImgId'] = licenseImgId;
    data['commercialRecordImgId'] = commercialRecordImgId;
    if (providerBranches != null) {
      data['providerBranches'] =
          providerBranches!.map((v) => v.toJson()).toList();
    }
    data['providerRequestsCount'] = providerRequestsCount;
    data['providerRating'] = providerRating;
    return data;
  }
}

class BranchModel {
  int? id;
  int? providerId;
  String? location;
  double? latitude;
  double? longitude;

  BranchModel(
      {this.id, this.providerId, this.location, this.latitude, this.longitude});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['providerId'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['providerId'] = providerId;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
