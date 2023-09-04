import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/features/auth/login/data/repo/login_repo.dart';
import 'package:provider_medical_valley/features/auth/login/presentation/bloc/loginState_state.dart';

import '../../../../home/home_screen/persentation/bloc/home_bloc.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc(this.loginRepo) : super(LoginStateEmpty());
  LoginRepo loginRepo;
  void loginUser(LoginEvent event) async {
    emit(LoginStateLoading());
    var loginUser = await loginRepo.login(event.mobilePhone);
    loginUser.fold((l) {
      emit(LoginStateError());
    }, (r) {
      emit(LoginStateSuccess(r));
      GetIt.instance<HomeBloc>().updateFcmToken();
    });
  }
}

class LoginEvent {
  String mobilePhone;

  LoginEvent(this.mobilePhone);
}
