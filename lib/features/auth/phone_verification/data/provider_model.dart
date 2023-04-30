class ProviderModel {
  ProviderResponseModel? data;
  String? token;

  ProviderModel({this.data, this.token});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProviderResponseModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class ProviderResponseModel {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  ProviderResponseModel? data;

  ProviderResponseModel(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  ProviderResponseModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  ProviderResponseModel.fromJson(json['data']) : null;
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

class ProviderDataModel {
  int? id;
  String? fullName;
  String? arFullName;
  String? email;
  String? mobile;
  String? license;
  String? commercialRecord;
  int? statusId;
  String? statusStr;
  String? logoImgId;
  String? licenseImgId;
  String? commercialRecordImgId;
  List<String>? providerBranches;
  String? providerRequestsCount;
  String? providerRating;

  ProviderDataModel(
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

  ProviderDataModel.fromJson(Map<String, dynamic> json) {
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
      providerBranches = [];
      json['providerBranches'].forEach((v) {
        providerBranches!.add( v);
      });
    }
    providerRequestsCount = json['providerRequestsCount'];
    providerRating = json['providerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
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
          providerBranches!.map((v) => v).toList();
    }
    data['providerRequestsCount'] = providerRequestsCount;
    data['providerRating'] = providerRating;
    return data;
  }
}
