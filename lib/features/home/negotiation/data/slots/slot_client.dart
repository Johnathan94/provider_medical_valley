
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
class SlotClient{
  Dio dio ;

  SlotClient(this.dio);

  getSlot(int dayId ,int serviceId)async{
    String user = LocalStorageManager.getUser();
    Map<String,dynamic > result = jsonDecode(user) ;
    int providerId = result["data"]["data"]["id"];
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Slots?providerId=$providerId&dayId=$dayId&serviceId=$serviceId");
    return response.data;
  }

}