import '../data/api_service/negotiations_client.dart';
import '../data/model/provider_reservations_model.dart';

class GetNegotiationsUseCase {
  ProviderNegotiationsClient client;

  GetNegotiationsUseCase(this.client);

  Future<ProviderNegotiationsModel> getNegotiations(
      int providerId, int page, int pageSize) async {
    var result = await client.getProviderNegotiations(page, pageSize);
    ProviderNegotiationsModel category =
        ProviderNegotiationsModel.fromJson(result);
    return category;
  }
}
