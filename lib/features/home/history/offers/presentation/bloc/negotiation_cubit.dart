import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/model/provider_reservations_model.dart';

import '../../../../../../core/base_service/network_error.dart';
import '../../domain/get_negotiations_use_case.dart';

part 'bloc/../negotiation_state.dart';

class NegotiationCubit extends Cubit<NegotiationState> {
  NegotiationCubit(this.getNegotiationsUseCase)
      : super(NegotiationInitial(ProviderNegotiationsModel()));
  GetNegotiationsUseCase getNegotiationsUseCase;

  bool isLoading = false;
  bool canFetchMore = true;

  getNegotiations(int page, int pageSize) async {
    try {
      canFetchMore = true;
      emit(LoadingNegotiationState(state.category));
      ProviderNegotiationsModel request =
          await getNegotiationsUseCase.getNegotiations(1, page, pageSize);
      emit(SuccessNegotiationState(request));
    } catch (e) {
      emit(ErrorNegotiationState(ErrorStates.serverError));
    }
  }

  void getMoreNegotiations(int page, int pageSize) async {
    try {
      if (isLoading || !canFetchMore) {
        return;
      }
      isLoading = true;
      final oldRequest = (state as SuccessNegotiationState).category;
      emit(LoadingMoreNegotiationsState(oldRequest));
      ProviderNegotiationsModel request =
          await getNegotiationsUseCase.getNegotiations(1, page, pageSize);
      if ((request.data?.results?.isEmpty ?? true) == true ||
          (request.data?.results?.length ?? 0) < 10) {
        canFetchMore = false;
      }
      request.data?.results = [
        ...oldRequest.data!.results!,
        ...request.data!.results!
      ];
      isLoading = false;
      emit(SuccessNegotiationState(request));
    } catch (e) {
      emit(ErrorLoadingMoreNegotiationsState(ErrorStates.serverError));
      isLoading = false;
    }
  }
}
