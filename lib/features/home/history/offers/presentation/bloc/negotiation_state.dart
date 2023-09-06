part of 'negotiation_cubit.dart';

@immutable
abstract class NegotiationState {
  final ProviderNegotiationsModel category;

  const NegotiationState(this.category);
}

class NegotiationInitial extends NegotiationState {
  const NegotiationInitial(super.category);
}

class SuccessNegotiationState extends NegotiationState {
  const SuccessNegotiationState(super.category);
}

class InitialNegotiationState extends NegotiationState {
  const InitialNegotiationState(super.category);
}

class ErrorNegotiationState extends NegotiationState {
  final ErrorStates states;

  ErrorNegotiationState(this.states) : super(ProviderNegotiationsModel());
}

class LoadingNegotiationState extends NegotiationState {
  const LoadingNegotiationState(super.category);
}

class LoadingMoreNegotiationsState extends NegotiationState {
  const LoadingMoreNegotiationsState(super.category);
}

class ErrorLoadingMoreNegotiationsState extends NegotiationState {
  final ErrorStates states;
  ErrorLoadingMoreNegotiationsState(this.states)
      : super(ProviderNegotiationsModel());
}
