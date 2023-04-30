
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';

class NotificationClient {
  Dio dio ;

  NotificationClient(this.dio);

    getNotifications()async{
    String userEncoded = LocalStorageManager.getUser();
    Map<String, dynamic> user = jsonDecode(userEncoded);
    Response response =  await dio.get("${dio.options.baseUrl}/Provider/GetNotifications?providerId=${user["data"]["data"]["id"]}",);
    return response.data;
  }
}