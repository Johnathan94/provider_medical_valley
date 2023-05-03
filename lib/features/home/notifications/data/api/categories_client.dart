
import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class NotificationClient {
  Dio dio ;

  NotificationClient(this.dio);

    getNotifications()async{
      ProviderData result = ProviderData.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/Provider/GetNotifications?providerId=${result.id}",);
    return response.data;
  }
}