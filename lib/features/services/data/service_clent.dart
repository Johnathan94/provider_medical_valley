
import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
class ServiceClient{
  Dio dio ;

  ServiceClient(this.dio);

  Future getAllServices( int pageNumber , int pageSize  )async{
    ProviderData user = ProviderData.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/Service/GetCategoriesServicesByProviderId?PageNumber=$pageNumber&PageSize=$pageSize&providerId=${user.id}",);
    return response.data;
  }

}