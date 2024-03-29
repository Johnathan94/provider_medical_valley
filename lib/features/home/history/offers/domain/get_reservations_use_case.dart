import 'package:provider_medical_valley/features/home/history/offers/data/model/provider_reservations_model.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';

import '../data/api_service/negotiations_client.dart';
import '../data/api_service/reservations_client.dart';

class GetReservationsUseCase {
  ProviderReservationsClient client;

  GetReservationsUseCase(this.client);

  Future<ProviderNegotiationsModel> getProviderReservations(
       int page, int pageSize) async {
    var result = await client.getProviderReservations(page, pageSize);
    ProviderNegotiationsModel category = ProviderNegotiationsModel.fromJson(result);
    return category;
  }
}
