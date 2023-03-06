import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/send_offer_repo.dart';

class NegotiationBloc extends Cubit<NegotiationState>{
  NegotiationBloc(this.sendOfferRepo):super(NegotiationState());
  SendOfferRepo sendOfferRepo;
  sendOffer (SendOffer sendOffer)async{
    emit(LoadingNegotiationState());
    var loginUser = await sendOfferRepo.sendOffer(sendOffer);
    loginUser.fold(
            (l) {
          emit(ErrorNegotiationState());
        }, (r) {
      emit(SuccessNegotiationState());
    }
    );
  }
}
class NegotiationState {}
class LoadingNegotiationState extends NegotiationState{}
class SuccessNegotiationState extends NegotiationState{}
class ErrorNegotiationState extends NegotiationState{}