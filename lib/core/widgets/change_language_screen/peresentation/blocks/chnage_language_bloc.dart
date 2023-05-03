import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_state.dart';

class LanguageBloc extends Cubit<LanguageState> {
  int x = 0;
  LanguageBloc() : super(LanguageState(locale :const Locale("en"))){
    x=30;
  }

  Stream<LanguageState> changeLanguage(Locale locale) async* {
    print(x);
    emit(LanguageState(locale: locale));
  }
}
