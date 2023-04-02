import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/features/profile/data/user_profile/get_profile_client.dart';
import 'package:provider_medical_valley/features/profile/data/user_profile/user_profile_model.dart';

import '../../../../core/failures/failures.dart';

abstract class GetProfileRepo {
  Future<Either<Failure, UserProfileModel>> getProfile(int id);
}

class GetProfileImpl extends GetProfileRepo {
  GetProfileClient getProfileClient;

  GetProfileImpl(this.getProfileClient);

  @override
  Future<Either<Failure, UserProfileModel>> getProfile(int id) async {
    try {
      var result = await getProfileClient.getMyProfile(id);
      if (result["responseCode"] >= 200 && result["responseCode"] < 300) {
        return Right(UserProfileModel.fromJson(result));
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
