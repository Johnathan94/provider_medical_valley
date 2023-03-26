import 'package:provider_medical_valley/features/home/history/offers/data/model/negotiatione_response.dart';

abstract class OffersState {}
 class OffersStateEmpty extends OffersState{}
 class OffersStateSuccess extends OffersState{
 NegotiationsResponse offersResponse ;
 OffersStateSuccess(this.offersResponse);
}
 class OffersStateLoading extends OffersState{}
 class OffersStateError extends OffersState{}
