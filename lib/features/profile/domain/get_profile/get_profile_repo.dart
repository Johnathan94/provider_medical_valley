import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/features/profile/data/user_profile/get_profile_client.dart';
import 'package:provider_medical_valley/features/profile/data/user_profile/user_profile_model.dart';

import '../../../../core/failures/failures.dart';

abstract class GetProfileRepo {
  Future<Either<Failure, ProviderProfileResponse>> getProfile(int id);
}

class GetProfileImpl extends GetProfileRepo {
  GetProfileClient getProfileClient;

  GetProfileImpl(this.getProfileClient);

  @override
  Future<Either<Failure, ProviderProfileResponse>> getProfile(int id) async {
    try {
      var result = await getProfileClient.getMyProfile(id);
      var providerProfileResponse = ProviderProfileResponse.fromJson(result);
      if (providerProfileResponse.responseCode! >= 200 && providerProfileResponse.responseCode! < 300) {
        return Right(providerProfileResponse);
      }
      return Left(ServerFailure(error: providerProfileResponse.message));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
