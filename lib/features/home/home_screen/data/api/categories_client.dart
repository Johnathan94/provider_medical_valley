
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';

class RequestsClient {
  Dio dio ;

  RequestsClient(this.dio);

  getRequests(int bookingTypeId , int page , int pageSize)async{
    String userEncoded = LocalStorageManager.getUser();
    Map<String, dynamic> user = jsonDecode(userEncoded);
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Requests?PageNumber=$page&PageSize=$pageSize&providerId=${user["provider"]["data"]["id"]}&BookingTypeId=$bookingTypeId",);
    return response.data;
  }
}