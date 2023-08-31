import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_request.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/send_offer_repo.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/send_offer_repo.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_repo.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_response_model.dart';

class NegotiationBloc extends Cubit<NegotiationState> {
  NegotiationBloc(this.sendOfferRepo, this.slotRepo, this.negotiateRepo)
      : super(NegotiationState());
  SendOfferRepo sendOfferRepo;
  NegotiateRepo negotiateRepo;
  SlotRepo slotRepo;
  getSlot(int branchId, int requestId) async {
    emit(LoadingSlotState());
    var loginUser = await slotRepo.getSlot(branchId, requestId);
    loginUser.fold((l) {
      emit(ErrorSlotState());
    }, (r) {
      if (r.data != null && r.data!.isNotEmpty) {
        emit(SuccessSlotState(r));
      } else {
        emit(ErrorSlotState());
      }
    });
  }

  sendOffer(SendOffer sendOffer) async {
    emit(LoadingNegotiationState());
    var loginUser = await sendOfferRepo.sendOffer(sendOffer);
    loginUser.fold((l) {
      emit(ErrorNegotiationState());
    }, (r) {
      emit(SuccessNegotiationState());
    });
  }

  negotiate(NegotiationRequest request) async {
    emit(LoadingNegotiationState());
    var negotiate = await negotiateRepo.negotiate(request);
    negotiate.fold((l) {
      emit(ErrorNegotiationState());
    }, (r) {
      emit(SuccessNegotiationState());
    });
  }
}

class NegotiationState {}

class LoadingNegotiationState extends NegotiationState {}

class SuccessNegotiationState extends NegotiationState {}

class ErrorNegotiationState extends NegotiationState {}

class LoadingSlotState extends NegotiationState {}

class SuccessSlotState extends NegotiationState {
  SlotResponse slotResponse;

  SuccessSlotState(this.slotResponse);
}

class ErrorSlotState extends NegotiationState {}
