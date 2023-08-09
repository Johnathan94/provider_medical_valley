import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/auth/login/data/repo/login_repo.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/domain/verify_otp_use_case.dart';

class OtpBloc extends Cubit<OtpState> {
  VerifyOtpUseCase verifyOtpUseCase;
  LoginRepo loginRepo;

  OtpBloc(this.verifyOtpUseCase, this.loginRepo) : super(IdleOtpState());

  Future verifyOtp(String otp, String mobile) async {
    emit(LoadingOtpState());
    var either = await verifyOtpUseCase.verifyOtp(otp, mobile);
    either.fold((l) {
      emit(ErrorOtpState());
    }, (r) {
      emit(SuccessOtpState());
    });
  }

  Future resendOtp(String mobile) async {
    emit(LoadingResendOtpState());
    var either = await loginRepo.login(mobile);
    either.fold((l) {
      emit(ResendOtpError());
    }, (r) {
      emit(ResendOtpSuccess());
    });
  }
}

abstract class OtpState {}

class LoadingOtpState extends OtpState {}

class LoadingResendOtpState extends OtpState {}

class SuccessOtpState extends OtpState {}

class ResendOtpSuccess extends OtpState {}

class ResendOtpError extends OtpState {}

class ErrorOtpState extends OtpState {}

class IdleOtpState extends OtpState {}
