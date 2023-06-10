import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';

import '../data/api_service/negotiations_client.dart';

class GetNegotiationsUseCase {
  ProviderNegotiationsClient client;

  GetNegotiationsUseCase(this.client);

  Future<RequestsResponse> getRequests(
      int bookingTypeId, int page, int pageSize) async {
    var result = await client.getProviderNegotiations(page, bookingTypeId, pageSize);
    RequestsResponse category = RequestsResponse.fromJson(result);
    return category;
  }
}
