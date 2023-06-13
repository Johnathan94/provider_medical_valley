import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/model/provider_reservations_model.dart';

import '../../../../../../core/base_service/network_error.dart';
import '../../../../home_screen/data/models/requets_model.dart';
import '../../../../home_screen/data/models/search_result.dart';
import '../../domain/get_negotiations_use_case.dart';

part 'bloc/../negotiation_state.dart';

class NegotiationCubit extends Cubit<NegotiationState> {
  NegotiationCubit(this.getNegotiationsUseCase) : super(NegotiationInitial());
  GetNegotiationsUseCase getNegotiationsUseCase;
  getNegotiations( int  page, int pageSize) async {
    try {
      emit(LoadingNegotiationState());
      ProviderNegotiationsModel request =
      await getNegotiationsUseCase.getNegotiations(1 , page, pageSize);
      emit(SuccessNegotiationState(request));
    } catch (e) {
      emit(ErrorNegotiationState(ErrorStates.serverError));
    }
  }

}
