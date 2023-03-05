import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_request_model.dart';
import '../../data/repo/book_request_repo.dart';

class BookRequestBloc extends Cubit<BookRequestState> {
  BookRequestRepo requestRepo;
  BookRequestBloc(this.requestRepo)
      : super(BookRequestState(BookedState.ideal));
  requestBook(BookRequestModel model) async {
    try {
      emit(BookRequestState(BookedState.loading));
      await requestRepo.requestBook(model);
      emit(BookRequestState(BookedState.success));
    } catch (e) {
      emit(BookRequestState(BookedState.fail));
    }
  }
}

class BookRequestState {
  BookedState state;

  BookRequestState(this.state);
}

enum BookedState { ideal, loading, success, fail }
