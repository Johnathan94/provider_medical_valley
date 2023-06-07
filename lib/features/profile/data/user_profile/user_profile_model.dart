import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class ProviderProfileResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  ProviderInfo? data;

  ProviderProfileResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  ProviderProfileResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? ProviderInfo.fromJson(json['data']) : null;
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

class ProviderInfo {
  int? id;
  String? fullName;
  String? arFullName;
  String? email;
  String? mobile;
  String? license;
  String? commercialRecord;
  int? userTypeId;
  String? userTypeStr;
  int? statusId;
  String? statusStr;
  String? logoImgId;
  String? vatNumber;
  String? licenseImgId;
  String? commercialRecordImgId;
  String? userAvatar;
  List<BranchModel>? providerBranches;
  int? providerRequestsCount;
  double? providerRating;

  ProviderInfo(
      {this.id,
      this.fullName,
      this.providerBranches,
      this.providerRequestsCount,
      this.providerRating,
      this.arFullName,
      this.email,
      this.vatNumber,
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

  ProviderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    arFullName = json['arFullName'];
    email = json['email'];
    mobile = json['mobile'];
    license = json['license'];
    userAvatar = json['userAvatar'] ?? "";
    commercialRecord = json['commercialRecord'];
    userTypeId = json['userTypeId'];
    userTypeStr = json['userTypeStr'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    logoImgId = json['logoImgId'];
    vatNumber = json['vatNumber'];
    licenseImgId = json['licenseImgId'];
    if (json['providerBranches'] != null) {
      providerBranches = <BranchModel>[];
      json['providerBranches'].forEach((v) {
        providerBranches!.add(BranchModel.fromJson(v));
      });
    }
    commercialRecordImgId = json['commercialRecordImgId'];
    providerRequestsCount = json['providerRequestsCount'];
    providerRating = json['providerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data['userAvatar'] = userAvatar;
    data['logoImgId'] = logoImgId;
    data['licenseImgId'] = licenseImgId;
    data['commercialRecordImgId'] = commercialRecordImgId;
    data['providerBranches'] = providerBranches;
    data['providerRequestsCount'] = providerRequestsCount;
    data['providerRating'] = providerRating;
    return data;
  }
}
