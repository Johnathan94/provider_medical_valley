import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/services/data/services_repo.dart';
import 'package:provider_medical_valley/features/services/data/services_responses.dart';

class ServicesBloc extends Cubit<ServicesState>{
  ServicesBloc(this.repo ):super(EmptyServicesState());
  ServiceRepo repo ;

  getAllServices (int pageSize , int pageNumber )async{
   emit(LoadingServicesState());
   var servicesResponse = await repo.getServices(pageNumber, pageSize);
   servicesResponse.fold(
           (l) {
         emit(ErrorServicesState());
       }, (right) {
     emit(SuccessServicesState(right));
   });
  }
}
abstract class ServicesState {}
 class EmptyServicesState extends ServicesState{}
 class SuccessServicesState extends ServicesState{
  ServicesResponse servicesResponse ;

  SuccessServicesState(this.servicesResponse);

 }
 class LoadingServicesState extends ServicesState{}
 class ErrorServicesState extends ServicesState{}