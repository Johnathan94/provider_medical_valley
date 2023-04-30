
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';

class BranchesClient {
  Dio dio ;

  BranchesClient(this.dio);

  getBranches()async{
    String userEncoded = LocalStorageManager.getUser();
    Map<String, dynamic> user = jsonDecode(userEncoded);
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Branches?providerId=41",);
    return response.data;
  }
}