import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/widgets/change_language_screen/peresentation/blocks/language_event.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';

import 'package:rxdart/rxdart.dart';

import '../../../../app_initialized.dart';
import '../../data/models/language_model.dart';
import '../blocks/chnage_language_bloc.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  late BehaviorSubject<LanguageModel> _languages = BehaviorSubject();
  late LanguageBloc _bloc ;

  @override
  initState() {
    _languages.sink.add(lang.first);
    _bloc = BlocProvider.of<LanguageBloc>(context);
    print(_bloc.x);

    super.initState();
  }

  @override
  dispose() {
    _languages.stream.drain();
    _languages.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return MyCustomAppBar(
        header: AppLocalizations.of(context)!.language_title,
        leadingIcon: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ));
  }

  getBody() {
    return StreamBuilder<LanguageModel>(
        stream: _languages.stream,
        builder: (context, snapshot) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: lang.length,
              padding:
                  const EdgeInsetsDirectional.only(start: 25, end: 25, top: 18),
              itemBuilder: (context, index) {
                return buildLangItem(lang[index]);
              });
        });
  }

  buildLangItem(LanguageModel language) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              changeLanguage(language);
              },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(language.title),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(language.subTitle),
                    ),
                  ],
                ),
                language.checked
                    ? Container(
                        decoration: const BoxDecoration(
                            color: greenCheckBox,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.check_box,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 10, end: 15.0),
            child: Divider(
              height: 0.4,
              color: dividerColor,
            ),
          )
        ],
      ),
    );
  }
  List<LanguageModel> lang = [
    LanguageModel(0 ,"English ", "English Language", true ),
    LanguageModel(1 ,"Arabic ", "اللغه العربيه", false ),
  ];
  changeLanguage(LanguageModel language) {
    for(var e in lang){
      e.checked= !e.checked;
    }
    _languages.sink.add(language);
    _bloc.changeLanguage(language.id == 1 ?
    const Locale("ar") :
    const Locale("en")
    );

  }
}
