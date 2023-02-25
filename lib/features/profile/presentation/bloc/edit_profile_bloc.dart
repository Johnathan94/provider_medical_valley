import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile_body.dart';
import 'package:provider_medical_valley/features/profile/domain/edit_profile_repo.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/edit_profile_state.dart';

class EditProfileBloc extends Cubit<EditProfileState>{
  EditProfileBloc(this.editProfileRepo) : super(InitialEditProfileState());
  EditProfileRepo editProfileRepo ;

  editProfile (EditProfileBody editProfileBody )async{
    emit(LoadingEditProfileState());
    var loginUser = await editProfileRepo.editProfile(editProfileBody);
    loginUser.fold(
            (l) {
          emit(ErrorEditProfileState());
        }, (r) {
      emit(SuccessEditProfileState());
    }
    );
  }
}
