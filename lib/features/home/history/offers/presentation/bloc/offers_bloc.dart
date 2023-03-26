import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/repo/offers_repo.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_state.dart';

class OffersBloc extends Cubit<OffersState >{
  OffersBloc(this.offersRepo): super(OffersStateEmpty());
  OffersRepo offersRepo ;
  void getOffers (NegotiationsEvent event )async{
    emit(OffersStateLoading());
    var offers = await offersRepo.getNegotiations(event.page , event.pageSize);
    offers.fold(
            (l) {
          emit(OffersStateError());
        }, (right) {
      emit(OffersStateSuccess(right));
    }
    );
  }


}
class NegotiationsEvent{
  final int page ,  pageSize ,  providerId;
  NegotiationsEvent(this. page , this. pageSize , this. providerId);
}