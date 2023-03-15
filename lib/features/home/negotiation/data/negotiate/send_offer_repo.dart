
import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_client.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_request.dart';

abstract class NegotiateRepo {
  Future<Either<Failure , Unit>> negotiate (NegotiateRequest model);
}
class NegotiateRepoImpl extends NegotiateRepo{
  NegotiateClient client ;

  NegotiateRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> negotiate(NegotiateRequest model) async {
    try
    {
      await client.negotiate(model);
        return const Right(unit);
    }
    catch(e){
      return Left(ServerFailure());
    }
  }
}