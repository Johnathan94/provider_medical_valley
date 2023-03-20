
import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_client.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_response_model.dart';

abstract class SlotRepo {
  Future<Either<Failure , SlotResponse>> getSlot (int serviceId);
}
class SlotRepoImpl extends SlotRepo{
  SlotClient client ;

  SlotRepoImpl(this.client);

  @override
  Future<Either<Failure , SlotResponse>> getSlot(int serviceId) async {
    try
    {
      var response = await client.getSlot(serviceId);
      SlotResponse slotResponse = SlotResponse.fromJson(response);
        return  Right(slotResponse);
    }
    catch(e){
      return Left(ServerFailure());
    }
  }
}