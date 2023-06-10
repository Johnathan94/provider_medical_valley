import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      RequestsResponse request =
      await getNegotiationsUseCase.getRequests(1 , page, pageSize);
      emit(SuccessNegotiationState(request));
    } catch (e) {
      emit(ErrorNegotiationState(ErrorStates.serverError));
    }
  }

}
