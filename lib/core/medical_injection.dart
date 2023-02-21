import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/features/auth/register/domain/register_usecase.dart';

import '../features/auth/login/data/api_service/login_client.dart';
import '../features/auth/login/data/repo/login_repo.dart';
import '../features/auth/login/presentation/bloc/login_bloc.dart';
import '../features/auth/register/data/api_service/register_client.dart';
import '../features/auth/register/data/repo/register_repo.dart';
import '../features/auth/register/presentation/register_bloc/register_bloc.dart';
import '../features/home/history/data/get_clinic_repo.dart';
import '../features/home/history/data/source/json_data.dart';
import '../features/home/history/domain/get_clinic_usecase.dart';
import '../features/home/history/presentation/bloc/clinics_bloc.dart';
import '../features/home/home_screen/data/api/categories_client.dart';
import '../features/home/home_screen/data/api/search_client.dart';
import '../features/home/home_screen/domain/get_categories_use_case.dart';
import '../features/home/home_screen/domain/search_with_keyword.dart';
import '../features/home/home_screen/persentation/bloc/home_bloc.dart';
import 'base_service/dio_manager.dart';

final getIt = GetIt.instance;

configureDependencies() {
  getIt.registerFactory(() =>
      ClinicsBloc(GetClinicUseCaseImpl(GetClinicRepoImpl(JsonDataSrc()))));
  getIt.registerFactory(() => RegisterBloc(RegisterUseCaseImpl(
      RegisterUserRepoImpl(RegisterClient(DioManager.getDio())))));
  getIt.registerFactory(
      () => LoginBloc(LoginRepoImpl(LoginClient(DioManager.getDio()))));
  getIt.registerFactory(() => HomeBloc(
      GetCategoriesUseCase(CategoriesClient(DioManager.getDio())),
      SearchWithKeyboard(SearchClient(DioManager.getDio()))));
}
