import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';

import '../data/api_service/negotiations_client.dart';
import '../data/api_service/reservations_client.dart';

class GetReservationsUseCase {
  ProviderReservationsClient client;

  GetReservationsUseCase(this.client);

  Future<RequestsResponse> getRequests(
      int bookingTypeId, int page, int pageSize) async {
    var result = await client.getProviderReservations(page, bookingTypeId, pageSize);
    RequestsResponse category = RequestsResponse.fromJson(result);
    return category;
  }
}
