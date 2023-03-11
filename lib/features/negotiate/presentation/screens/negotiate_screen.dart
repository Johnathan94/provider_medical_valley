import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/calendar/persentation/screens/calendar_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/dialogs/loading_dialog.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/home_screen/data/models/categories_model.dart';
import '../../../home/home_screen/data/models/requets_model.dart';
import '../../../home/negotiation/bloc/negotiation_bloc.dart';
import '../../../home/negotiation/data/offer_model.dart';

class NegotiateScreen extends StatefulWidget {
  final BookRequest result;
  final bool immediateCard;
  final bool otherCard;
  const NegotiateScreen(
      {Key? key,
      required this.result,
      this.immediateCard = false,
      this.otherCard = false})
      : super(key: key);

  @override
  State<NegotiateScreen> createState() => _NegotiateScreenState();
}

class _NegotiateScreenState extends State<NegotiateScreen> {
  List<String> slots = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "01:00",
    "01:30",
    "02:00",
  ];

  NegotiationBloc negotiationBloc = GetIt.instance<NegotiationBloc>();

  TextEditingController controller = TextEditingController();

  BehaviorSubject<int> selectedBorder = BehaviorSubject.seeded(0);

  final _formKey = GlobalKey<FormState>();
  late List<SpecialistModel> models;

  Services myService = Services(
      id: 1,
      englishName: "englishName",
      arabicName: "arabicName",
      price: 50.0,
      dateFrom: "dateFrom",
      dateTo: "dateTo",
      discount1: 10,
      discount2: 20,
      discount3: 30,
      description: "description",
      statusId: 4,
      autoReply: true,
      isActive: true,
      categoryId: 30,
      categoryStr: "categoryStr");

  @override
  Widget build(BuildContext context) {
    models = [
      SpecialistModel(1, AppLocalizations.of(context)!.consultant, false),
      SpecialistModel(2, AppLocalizations.of(context)!.specialist, false),
    ];
    return Scaffold(
      appBar: MyCustomAppBar(
        header: AppLocalizations.of(context)!.negotiation,
        leadingIcon: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BlocListener<NegotiationBloc, NegotiationState>(
                bloc: negotiationBloc,
                listener: (context, state) {
                  if (state is LoadingNegotiationState) {
                    LoadingDialogs.showLoadingDialog(context);
                  } else if (state is SuccessNegotiationState) {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      onConfirmBtnTap: () async {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      type: CoolAlertType.success,
                      text: AppLocalizations.of(context)!.offer_sent_success,
                    );
                  } else {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      onConfirmBtnTap: () async {
                        Navigator.pop(context);
                      },
                      type: CoolAlertType.error,
                      text: AppLocalizations.of(context)!.something_went_wrong,
                    );
                  }
                },
                child: Container(),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                                image: const DecorationImage(
                                  image: AssetImage(personImage),
                                )),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.result.userStr.toString(),
                                style: AppStyles
                                    .baloo2FontWith500WeightAnd22Size
                                    .copyWith(color: blackColor, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffEB8B17),
                                    size: 16,
                                  ),
                                  Text(
                                    "4.2",
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd12Size
                                        .copyWith(color: lightGrey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    cardIconOne,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    widget.result.categoryStr.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd16Size
                                        .copyWith(color: blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  SvgPicture.asset(cardIconTwo),
                                  SizedBox(width: 5.w),
                                  Text(
                                    widget.result.serviceStr.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd16Size
                                        .copyWith(color: blackColor),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 16, end: 16),
                      child: Text(
                        AppLocalizations.of(context)!.send_negotiation,
                        style: AppStyles.baloo2FontWith500WeightAnd16Size
                            .copyWith(color: blackColor),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 16, end: 16),
                      child: Text(
                        widget.otherCard
                            ? AppLocalizations.of(context)!
                                .schedule_an_appointment
                            : AppLocalizations.of(context)!.choose_time,
                        style: AppStyles.baloo2FontWith500WeightAnd16Size
                            .copyWith(color: blackColor),
                      ),
                    ),
                    widget.otherCard
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 30, end: 30, top: 15),
                                child: PrimaryButton(text: "15,Sep,2023"),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 30, end: 30),
                                child: PrimaryButton(
                                  text: AppLocalizations.of(context)!
                                      .another_date,
                                  backgroundColor: lightGreyColor,
                                  isLightButton: true,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalenderScreen(
                                                    services: myService)));
                                  },
                                ),
                              ),
                            ],
                          )
                        : Wrap(
                            children: slots
                                .map((e) =>
                                    _buildSlot(context, slots.indexOf(e)))
                                .toList(),
                          ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 16, end: 16),
                      child: Text(
                        AppLocalizations.of(context)!.enter_price,
                        style: AppStyles.baloo2FontWith400WeightAnd14Size
                            .copyWith(color: blackColor),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 16, end: 16),
                      child: SizedBox(
                        width: 220.w,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller,
                          validator: (text) => text!.isEmpty
                              ? AppLocalizations.of(context)!.price_invalid
                              : null,
                          decoration: InputDecoration(
                              suffix: Text(
                                "SR",
                                style:
                                    AppStyles.baloo2FontWith400WeightAnd14Size,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: grey)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    widget.immediateCard
                        ? ListView.builder(
                            itemCount: models.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 30, end: 30, top: 15),
                                decoration: const BoxDecoration(
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          color: shadowColor)
                                    ]),
                                child: RadioListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    activeColor: blackColor,
                                    value: models[index].selected,
                                    groupValue: models[index],
                                    onChanged: (newValue) {
                                      models[index].selected =
                                          !models[index].selected;
                                    },
                                    title: Text(
                                      models[index].name.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              );
                            })
                        : Container(),
                  ],
                ),
              ),
              Positioned(
                bottom: widget.immediateCard ? 30 : 150,
                left: 25,
                right: 25,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: PrimaryButton(
                    onPressed: () {
                      String userEncoded = LocalStorageManager.getUser();
                      Map<String, dynamic> user = jsonDecode(userEncoded);
                      if (_formKey.currentState!.validate()) {
                        negotiationBloc.sendOffer(SendOffer(
                          price: int.parse(controller.text),
                          requestId: widget.result.id,
                          id: user["data"]["id"],
                          userId: widget.result.userId,
                          slot: slots[selectedBorder.value],
                        ));
                      } else {
                        context.showSnackBar(
                            AppLocalizations.of(context)!.please_fill_all_data);
                      }
                    },
                    text: AppLocalizations.of(context)!.send,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlot(BuildContext context, int index) {
    return StreamBuilder<int>(
        stream: selectedBorder.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => selectedBorder.sink.add(index),
            child: Container(
              width: 80.w,
              height: 52.h,
              alignment: Alignment.center,
              margin:
                  const EdgeInsetsDirectional.only(start: 15, end: 10, top: 30),
              decoration: BoxDecoration(
                  color:
                      selectedBorder.value != index ? whiteColor : primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: selectedBorder.value != index
                      ? Border.all(color: borderGrey)
                      : null,
                  boxShadow: const [
                    BoxShadow(
                        color: shadowColor,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        spreadRadius: 2)
                  ]),
              child: Text(
                slots[index],
                style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                    color:
                        selectedBorder.value != index ? blackColor : whiteColor,
                    decoration: TextDecoration.none),
              ),
            ),
          );
        });
  }
}

class SpecialistModel {
  int id;
  String name;
  bool selected;

  SpecialistModel(this.id, this.name, this.selected);
}
