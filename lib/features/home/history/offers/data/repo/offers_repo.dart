import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/api_service/offers_client.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/model/negotiatione_response.dart';
import 'package:provider_medical_valley/main.dart';

abstract class OffersRepo {
  Future<Either<Failure , NegotiationsResponse>> getNegotiations (int page , int pageSize );
}
 class OffersRepoImpl extends OffersRepo{
  OffersClient client ;

  OffersRepoImpl(this.client);

  @override
  Future<Either<Failure , NegotiationsResponse>> getNegotiations(int page , int pageSize ) async {
    try
     {
       String user = LocalStorageManager.getUser();
       Map<String , dynamic > currentUser = {} ;
       currentUser =  jsonDecode(user);
       var result = await client.getOffers(page, pageSize,currentUser["provider"]["data"]["id"],);
       NegotiationsResponse response = NegotiationsResponse.fromJson(result);
       if(response.responseCode==200){
         negoNumber.sink.add(
             (response.data?.results?.length?? 0) + (negoNumber.value == 10 ?  negoNumber.value : 0));
        return  Right(response);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }

 }