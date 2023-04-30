import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/branches/data/model/branches_response_model.dart';
import 'package:provider_medical_valley/features/branches/domain/get_branches_use_case.dart';

class BranchesBloc extends Cubit<BranchesState> {
  GetBranchesUseCase getBranchesUseCase;

  BranchesBloc(this.getBranchesUseCase) : super(BranchesStateIdle());

  getBranches() async {
    try {
      emit(BranchesStateLoading());
      var res = await getBranchesUseCase.getBranches();
      res.fold(
          (l) => emit(BranchesStateError()),
          (r) => emit(BranchesStateSuccess(r))
      );
    } catch (e) {
      emit(BranchesStateError());
    }
  }
}

abstract class BranchesState {}

class BranchesStateLoading extends BranchesState {}

class BranchesStateSuccess extends BranchesState {
  List<BranchesResponseModel> branches;

  BranchesStateSuccess(this.branches);
}

class BranchesStateError extends BranchesState {}

class BranchesStateIdle extends BranchesState {}
