import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';

import '../data/api/categories_client.dart';

class GetRequestsUseCase {
  RequestsClient client;

  GetRequestsUseCase(this.client);

  Future<RequestsResponse> getRequests(int bookingTypeId , int page , int pageSize) async {
    var result = await client.getRequests(bookingTypeId , page, pageSize);
    RequestsResponse category = RequestsResponse.fromJson(result);
    return category;
  }
}
