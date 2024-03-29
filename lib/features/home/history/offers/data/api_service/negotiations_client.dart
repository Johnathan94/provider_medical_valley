import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class ProviderNegotiationsClient {
  Dio dio;

  ProviderNegotiationsClient(this.dio);

  getProviderNegotiations(int page, int pageSize) async {
    ProviderData user = ProviderData.fromJson(LocalStorageManager.getUser()!);
    Response response = await dio.get(
      "${dio.options.baseUrl}/Request/ProviderOffers?PageNumber=$page&PageSize=$pageSize&ProviderId=${user.id}",
    );
    return response.data;
  }
}
