part of 'reservations_cubit.dart';

@immutable
abstract class ReservationsState {}


class ReservationsInitial extends ReservationsState {}

class SuccessReservationsState extends ReservationsState {
  ProviderReservationsModel category;

  SuccessReservationsState(this.category);
}

class InitialReservationsState extends ReservationsState {}

class ErrorReservationsState extends ReservationsState {
  ErrorStates states;

  ErrorReservationsState(this.states);
}

class LoadingReservationsState extends ReservationsState {}
