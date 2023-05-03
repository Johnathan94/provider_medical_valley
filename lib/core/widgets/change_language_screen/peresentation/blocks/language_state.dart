import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class LanguageState extends Equatable{
  Locale locale;

  LanguageState(
     {
    required this.locale,
  });
  @override
  List<Object> get props => [locale];
}
