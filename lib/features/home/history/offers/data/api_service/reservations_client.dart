

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class ProviderReservationsClient {
  Dio dio ;

  ProviderReservationsClient(this.dio);


  getProviderReservations( int page , int pageSize)async{
    ProviderData user = ProviderData.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/Request/ProviderReservations?PageNumber=$page&PageSize=$pageSize&ProviderId=${user.id}",);
    return response.data;
  }
}