import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/branches/data/api/branches_cleint.dart';
import 'package:provider_medical_valley/features/branches/data/model/branches_response_model.dart';

abstract class GetBranchesUseCase {
  Future<Either <ServerFailure , List<BranchesResponseModel>>> getBranches();
}
class GetBranchesUseCaseImpl extends GetBranchesUseCase{
  BranchesClient branchesClient ;

  GetBranchesUseCaseImpl(this.branchesClient);

  @override
  Future<Either<ServerFailure, List<BranchesResponseModel>>> getBranches() async {
    var result = await branchesClient.getBranches();
    List<BranchesResponseModel> branches = [];
      if((result as List).isNotEmpty){
        result.forEach((element) {
          branches.add(BranchesResponseModel.fromJson(element));
        });
        return Right(branches);
      }
      else {
        return Left(ServerFailure());
      }
  }
}