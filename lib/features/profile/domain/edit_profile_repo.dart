import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile_body.dart';

abstract class EditProfileRepo {
  Future<Either<Failure , Unit>> editProfile (EditProfileBody editProfileBody);
}
 class EditProfileRepoImpl extends EditProfileRepo{
  EditProfileClient  client ;

  EditProfileRepoImpl(this.client);

  @override
  Future<Either<Failure, Unit>> editProfile(EditProfileBody editProfileBody) async{
    try
    {
      var result =  await client.editProfile(editProfileBody);
      if(result["responseCode"]>=200 && result["responseCode"]< 300){
        return const Right(unit);
      }
      return Left(ServerFailure());
    }
    catch(e){
      return Left(ServerFailure());
    }
  }


}