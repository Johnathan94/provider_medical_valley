import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/terms_and_conditions/persentation/bloc/terms_and_conditions_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/TermsAndConditionsState.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final BehaviorSubject<bool> _checkBoxBehaviourSubject =
      BehaviorSubject<bool>();

  final TermsAndConditionsBloc _termsAndConditionsBloc =
      GetIt.instance<TermsAndConditionsBloc>();

  @override
  initState() {
    _checkBoxBehaviourSubject.sink.add(false);
    _termsAndConditionsBloc.getTermsAndConditions();
    super.initState();
  }

  @override
  dispose() {
    _checkBoxBehaviourSubject.stream.drain();
    _checkBoxBehaviourSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: getBody(context),
    );
  }

  getAppBar(BuildContext context) {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.terms_and_condition,
      leadingIcon: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          color: whiteColor,
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
      bloc: _termsAndConditionsBloc,
      builder: (context, state) {
        if (state is LoadingTermsAndConditionsState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessTermsAndConditionsState) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 30, start: 30, end: 30),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            getLocalizedTerms(state),
                            style: AppStyles.baloo2FontWith400WeightAnd20Size
                                .copyWith(color: blackColor),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          );
        } else {
          return Center(
              child: Text(AppLocalizations.of(context)!.there_is_no_data));
        }
      },
    );
  }

  String getLocalizedTerms(SuccessTermsAndConditionsState state) {
    if (state.termsAndConditionsModel.data?.termsConditions != null) {
      if (LocalStorageManager.getCurrentLanguage() == "ar") {
        return state.termsAndConditionsModel.data!.termsConditions!;
      } else {
        return state.termsAndConditionsModel.data!.termsConditionsEn!;
      }
    } else {
      return "";
    }
  }
}
