class LoginResponse {
  Provider? provider;
  String? token;

  LoginResponse({this.provider, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ?  Provider.fromJson(json['provider'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Provider {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  ProviderData? data;

  Provider(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  Provider.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  ProviderData.fromJson(json['data']) : null;
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

class ProviderData {
  int? id;
  String? fullName;
  String? email;
  String? mobile;
  String? license;
  String? commercialRecord;
  int? userTypeId;
  int? statusId;
  String? statusStr;
  String? licenseImage;
  String? commercialRecordImage;
  String? userTypeStr;

  ProviderData(
      {this.id,
        this.fullName,
        this.email,
        this.mobile,
        this.license,
        this.commercialRecord,
        this.userTypeId,
        this.statusId,
        this.statusStr,
        this.licenseImage,
        this.commercialRecordImage,
        this.userTypeStr});

  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'];
    license = json['license'];
    commercialRecord = json['commercialRecord'];
    userTypeId = json['userTypeId'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    licenseImage = json['licenseImage'];
    commercialRecordImage = json['commercialRecordImage'];
    userTypeStr = json['userTypeStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['license'] = license;
    data['commercialRecord'] = commercialRecord;
    data['userTypeId'] = userTypeId;
    data['statusId'] = statusId;
    data['statusStr'] = statusStr;
    data['licenseImage'] = licenseImage;
    data['commercialRecordImage'] = commercialRecordImage;
    data['userTypeStr'] = userTypeStr;
    return data;
  }
}
