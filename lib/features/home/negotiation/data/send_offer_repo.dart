
import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/send_offer_client.dart';

abstract class SendOfferRepo {
  Future<Either<Failure , Unit>> sendOffer (SendOffer model);
}
class SendOfferRepoImpl extends SendOfferRepo{
  SendOfferClient client ;

  SendOfferRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> sendOffer(SendOffer model) async {
    try
    {
      var result = await client.sendOffer(model);
      if(result["responseCode"]==200){
        return const Right(unit);
      }
      return Left(ServerFailure());
    }
    catch(e){
      return Left(ServerFailure());
    }
  }
}