import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/api_service/offers_client.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/repo/offers_repo.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/bloc/negotiation_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_client.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/send_offer_repo.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/send_offer_client.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/send_offer_repo.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_client.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_repo.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile.dart';
import 'package:provider_medical_valley/features/profile/data/user_profile/get_profile_client.dart';
import 'package:provider_medical_valley/features/profile/domain/edit_profile_repo.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/get_profile/get_profile_bloc.dart';
import 'package:provider_medical_valley/features/services/data/service_clent.dart';
import 'package:provider_medical_valley/features/services/data/services_repo.dart';
import 'package:provider_medical_valley/features/services/presentation/services_bloc.dart';

import '../features/auth/login/data/api_service/login_client.dart';
import '../features/auth/login/data/repo/login_repo.dart';
import '../features/auth/login/presentation/bloc/login_bloc.dart';
import '../features/auth/register/data/api_service/register_client.dart';
import '../features/auth/register/data/repo/register_repo.dart';
import '../features/auth/register/domain/register_usecase.dart';
import '../features/auth/register/presentation/register_bloc/register_bloc.dart';
import '../features/calendar/data/book_request_client.dart';
import '../features/calendar/data/repo/book_request_repo.dart';
import '../features/calendar/persentation/bloc/book_request_bloc.dart';
import '../features/home/history/data/get_clinic_repo.dart';
import '../features/home/history/data/source/json_data.dart';
import '../features/home/history/domain/get_clinic_usecase.dart';
import '../features/home/history/presentation/bloc/clinics_bloc.dart';
import '../features/home/home_screen/data/api/categories_client.dart';
import '../features/home/home_screen/domain/get_requests_use_case.dart';
import '../features/home/home_screen/persentation/bloc/home_bloc.dart';
import '../features/profile/domain/get_profile/get_profile_repo.dart';
import '../features/terms_and_conditions/data/terms_and_conditions_client.dart';
import '../features/terms_and_conditions/domain/terms_and_conditions_repo.dart';
import '../features/terms_and_conditions/persentation/bloc/terms_and_conditions_bloc.dart';
import 'base_service/dio_manager.dart';

final getIt = GetIt.instance;

configureDependencies() {
  getIt.registerFactory(() =>
      ClinicsBloc(GetClinicUseCaseImpl(GetClinicRepoImpl(JsonDataSrc()))));
  getIt.registerFactory(() => RegisterBloc(RegisterUseCaseImpl(
      RegisterUserRepoImpl(RegisterClient(DioManager.getDio())))));
  getIt.registerFactory(
      () => BookRequestBloc(BookRequestRepo(BookRequestClient())));
  getIt.registerFactory(
      () => LoginBloc(LoginRepoImpl(LoginClient(DioManager.getDio()))));
  getIt.registerFactory(() => HomeBloc(
        GetRequestsUseCase(RequestsClient(DioManager.getDio())),
      ));
  getIt.registerFactory(() => EarliestBloc(
        GetRequestsUseCase(RequestsClient(DioManager.getDio())),
      ));
  getIt.registerFactory(() => ScheduledBloc(
        GetRequestsUseCase(RequestsClient(DioManager.getDio())),
      ));
  getIt.registerFactory(() => NegotiationBloc(
        SendOfferRepoImpl(SendOfferClient(DioManager.getDio())),
        SlotRepoImpl(SlotClient(DioManager.getDio())),
        NegotiateRepoImpl(
          NegotiateClient(DioManager.getDio()),
        ),
      ));
  getIt.registerFactory(
      () => OffersBloc(OffersRepoImpl(OffersClient(DioManager.getDio()))));
  getIt.registerFactory(() => EditProfileBloc(
      EditProfileRepoImpl(EditProfileClient(DioManager.getDio()))));
  getIt.registerFactory(
      () => ServicesBloc(ServiceRepo(ServiceClient(DioManager.getDio()))));
  getIt.registerFactory(() =>
      GetProfileBloc(GetProfileImpl(GetProfileClient(DioManager.getNewDio()))));
  getIt.registerFactory(() =>
      TermsAndConditionsBloc(TermsAndConditionsImpl(TermsAndConditionsClient(DioManager.getNewDio()))));

}
