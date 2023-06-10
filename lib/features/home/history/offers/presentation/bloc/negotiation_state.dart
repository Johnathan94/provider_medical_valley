part of 'negotiation_cubit.dart';

@immutable
abstract class NegotiationState {}

class NegotiationInitial extends NegotiationState {}

class SuccessNegotiationState extends NegotiationState {
  RequestsResponse category;

  SuccessNegotiationState(this.category);
}

class InitialNegotiationState extends NegotiationState {}

class ErrorNegotiationState extends NegotiationState {
  ErrorStates states;

  ErrorNegotiationState(this.states);
}

class LoadingNegotiationState extends NegotiationState {}
