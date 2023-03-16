
import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/auth/login/data/api_service/login_client.dart';
import 'package:provider_medical_valley/features/auth/login/data/login_response-model.dart';

abstract class LoginRepo {
  Future<Either<Failure , Unit>> login (String mobile);
}
 class LoginRepoImpl extends LoginRepo{
  LoginClient client ;

  LoginRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> login(String mobile) async {
    try
     {
       var result = await client.login(mobile);
       LoginResponse response = LoginResponse.fromJson(result);
       if(response.provider?.responseCode == 200){
          LocalStorageManager.saveToken(response.token!);
          LocalStorageManager.saveUser(result);
         return const Right(unit);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}