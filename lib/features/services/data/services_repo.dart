import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/services/data/service_clent.dart';
import 'package:provider_medical_valley/features/services/data/services_responses.dart';

class ServiceRepo{
  ServiceClient serviceClient ;

  ServiceRepo(this.serviceClient);

  Future<Either<Failure , ServicesResponse>> getServices(int pageNumber , int pageSize)async {
    try
     {
       final response = await serviceClient.getAllServices(pageNumber, pageSize);
       ServicesResponse servicesResponse = ServicesResponse.fromJson(response);
       if(servicesResponse.responseCode  == 200){
       return Right(servicesResponse);
       }else {
         return Left(ServerFailure());
       }
     }
      catch(e){
        return Left(ServerFailure());
      }

  }
}