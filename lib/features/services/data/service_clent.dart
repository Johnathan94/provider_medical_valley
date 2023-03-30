
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
class ServiceClient{
  Dio dio ;

  ServiceClient(this.dio);

  Future getAllServices( int pageNumber , int pageSize  )async{
    String user = LocalStorageManager.getUser();
    Map currentUser =  jsonDecode(user);
    Response response =  await dio.get("${dio.options.baseUrl}/Service/GetCategoriesServicesByProviderId?PageNumber=$pageNumber&PageSize=$pageSize&providerId=${currentUser["provider"]["data"]["id"]}",);
    return response.data;
  }

}