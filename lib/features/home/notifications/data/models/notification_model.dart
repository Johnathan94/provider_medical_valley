class NotificationResponseModel {
  bool? succeeded;
  String? message;
  Null? messageCode;
  int? responseCode;
  Null? validationIssue;
  List<NotificationModel>? data;

  NotificationResponseModel(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(new NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeeded'] = this.succeeded;
    data['message'] = this.message;
    data['messageCode'] = this.messageCode;
    data['responseCode'] = this.responseCode;
    data['validationIssue'] = this.validationIssue;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  String? englishText;
  String? arabicText;
  int? userId;
  String? userName;
  int? providerId;
  String? providerName;
  int? notificationActionId;
  String? notificationActionStr;
  int? requestId;
  Null? offerId;

  NotificationModel(
      {this.englishText,
        this.arabicText,
        this.userId,
        this.userName,
        this.providerId,
        this.providerName,
        this.notificationActionId,
        this.notificationActionStr,
        this.requestId,
        this.offerId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    englishText = json['englishText'];
    arabicText = json['arabicText'];
    userId = json['userId'];
    userName = json['userName'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    notificationActionId = json['notificationActionId'];
    notificationActionStr = json['notificationActionStr'];
    requestId = json['requestId'];
    offerId = json['offerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['englishText'] = this.englishText;
    data['arabicText'] = this.arabicText;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['providerId'] = this.providerId;
    data['providerName'] = this.providerName;
    data['notificationActionId'] = this.notificationActionId;
    data['notificationActionStr'] = this.notificationActionStr;
    data['requestId'] = this.requestId;
    data['offerId'] = this.offerId;
    return data;
  }
}
