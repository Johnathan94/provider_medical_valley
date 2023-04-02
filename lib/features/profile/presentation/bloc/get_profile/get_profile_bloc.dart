import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/profile/domain/get_profile/get_profile_repo.dart';

import 'get_profile_state.dart';

class GetProfileBloc extends Cubit<GetProfileState> {
  GetProfileBloc(this.getProfileRepo) : super(InitialGetProfileState());
  GetProfileRepo getProfileRepo;

  getMyProfile(int id) async {
    emit(LoadingGetProfileState());
    var userModel = await getProfileRepo.getProfile(id);
    userModel.fold((l) {
      emit(ErrorGetProfileState());
    }, (r) {
      emit(SuccessGetProfileState(r));
    });
  }
}
