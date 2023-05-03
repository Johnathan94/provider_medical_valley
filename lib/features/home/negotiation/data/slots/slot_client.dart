
import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
class SlotClient{
  Dio dio ;

  SlotClient(this.dio);

  getSlot(int dayId ,int serviceId)async{
    ProviderData result = ProviderData.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Slots?providerId=${result.id}&dayId=$dayId&serviceId=$serviceId");
    return response.data;
  }

}