import 'package:provider_medical_valley/features/profile/data/user_profile/user_profile_model.dart';

abstract class GetProfileState {}

class InitialGetProfileState extends GetProfileState {}

class SuccessGetProfileState extends GetProfileState {
  ProviderProfileResponse model;
  SuccessGetProfileState(this.model);
}

class ErrorGetProfileState extends GetProfileState {}

class LoadingGetProfileState extends GetProfileState {}
