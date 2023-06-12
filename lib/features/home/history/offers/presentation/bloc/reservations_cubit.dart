import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/base_service/network_error.dart';
import '../../data/model/provider_reservations_model.dart';
import '../../domain/get_reservations_use_case.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  GetReservationsUseCase getReservationsUseCase;

  ReservationsCubit(this.getReservationsUseCase) : super(ReservationsInitial());

  getReservations(int page, int pageSize) async {
    try {
      emit(LoadingReservationsState());
      ProviderReservationsModel request =
          await getReservationsUseCase.getRequests(page, pageSize);
      emit(SuccessReservationsState(request));
    } catch (e) {
      emit(ErrorReservationsState(ErrorStates.serverError));
    }
  }
}

