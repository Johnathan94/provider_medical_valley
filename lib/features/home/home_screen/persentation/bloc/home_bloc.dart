import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/core/base_service/network_error.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';

import '../../domain/get_requests_use_case.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<MyHomeState> {
  GetRequestsUseCase getRequestsUseCase;

  HomeBloc(this.getRequestsUseCase) : super(InitialHomeState());
}

class EarliestBloc extends Cubit<MyHomeState> {
  GetRequestsUseCase getRequestsUseCase;

  EarliestBloc(this.getRequestsUseCase) : super(InitialHomeState());

  getEarliestRequests(int page, int pageSize) async {
    try {
      emit(LoadingHomeState());
      RequestsResponse request =
          await getRequestsUseCase.getRequests(2, page, pageSize);
      emit(SuccessHomeState(request));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }
}

class ScheduledBloc extends Cubit<MyHomeState> {
  GetRequestsUseCase getRequestsUseCase;

  ScheduledBloc(this.getRequestsUseCase) : super(InitialHomeState());

  getScheduledRequests(int page, int pageSize) async {
    try {
      emit(LoadingHomeState());
      RequestsResponse request =
          await getRequestsUseCase.getRequests(3, page, pageSize);
      emit(SuccessHomeState(request));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }
}
