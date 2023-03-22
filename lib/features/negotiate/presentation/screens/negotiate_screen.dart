
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/calendar/persentation/screens/calendar_screen.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_request.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_response_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/dialogs/loading_dialog.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/home_screen/data/models/categories_model.dart';
import '../../../home/home_screen/data/models/requets_model.dart';
import '../../../home/negotiation/bloc/negotiation_bloc.dart';

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


  NegotiationBloc negotiationBloc = GetIt.instance<NegotiationBloc>();

  TextEditingController controller = TextEditingController();

  BehaviorSubject<int> selectedBorder = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isButtonEnabled = BehaviorSubject.seeded(false);

  final _formKey = GlobalKey<FormState>();
  late List<SpecialistModel> models;
  BehaviorSubject<int> selectedModel = BehaviorSubject();

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
  void initState() {
    DateTime now = DateTime.now();
    negotiationBloc.getSlot(getDayId(now.weekday) , widget.result.id!);
    super.initState();
  }
  int getDayId(int weedDay) {
    return weedDay == 6 ? 1 :
    weedDay== 7 ? 2:
    weedDay+2;
  }
  @override
  void didChangeDependencies() {
    models = [
      SpecialistModel(1, AppLocalizations.of(context)!.consultant, false),
      SpecialistModel(2, AppLocalizations.of(context)!.specialist, false),
    ];
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        header: AppLocalizations.of(context)!.negotiation,
        leadingIcon: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                } else if (state is ErrorNegotiationState){
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
                  middleWidget(context),
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
                              borderSide: BorderSide(color: primaryColor)),
                        ),
                        onChanged: (text){
                          text.isNotEmpty ?
                          isButtonEnabled.sink.add(true) :
                          isButtonEnabled.sink.add(false) ;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  immediateWidget(),
                ],
              ),
            ),
            continueButton(context),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget immediateWidget() {
    return widget.immediateCard
                      ? StreamBuilder<int>(
                        stream: selectedModel.stream,
                        builder: (context, snapshot) {
                          return Column(
                              children: models.map((model) => Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 30, end: 30, top: 15),
                                padding: const EdgeInsetsDirectional.only(
                                    start: 15, end: 15, top: 15,bottom: 15),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text(
                                      model.name.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                      onTap : ()
                                      {
                                        selectedModel.sink.add(models.indexOf(model));
                                      },
                                      child: Icon(
                                        selectedModel.hasValue ?
                                        selectedModel.value ==
                                            models.indexOf(model)?
                                         Icons.check_circle : Icons.circle_outlined :Icons.circle_outlined
                                      ),
                                    ),

                                  ],
                                ),
                              )).toList()
                                );
                        }
                      )
                      : Container();
  }

  Widget middleWidget(BuildContext context) {
    return widget.otherCard
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
                      : BlocBuilder<NegotiationBloc, NegotiationState>(
                                buildWhen: (prev, cur)=>
                                cur is SuccessSlotState || cur is ErrorSlotState || cur is LoadingSlotState,
                                bloc: negotiationBloc,
                                builder: (context, state) {
                                  if(state is SuccessSlotState){
                                    List<Periods>? periods = state.slotResponse.serviceDaySlots?.first.periods;
                                    return Wrap(
                                      children: periods!
                                          .map((e) =>
                                          _buildSlot(context, e))
                                          .toList(),
                                    );
                                  }
                                  else if(state is ErrorSlotState){
                                    return const Text("There is an error ");
                                  }
                                  else if (state is LoadingSlotState){
                                    return const CircularProgressIndicator();
                                  }
                                  return Container();
                                }
                            );
  }

  continueButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isButtonEnabled,
      builder: (context, snapshot) {
        return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsetsDirectional.only(start: 25 , end: 25, top: 30),
                  child: PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && selectedBorder.value != 0 ) {
                        negotiationBloc.negotiate(NegotiationRequest(
                          price: int.parse(controller.text),
                          negotiateId: widget.result.id,
                          periodId: selectedBorder.value,
                        ));
                      } else {
                        context.showSnackBar(
                            AppLocalizations.of(context)!.please_fill_all_data);
                      }
                    },
                    text: AppLocalizations.of(context)!.send,
                    backgroundColor: snapshot.hasData && snapshot.data == true?
                    primaryColor: greyButton,
                      isLightButton: snapshot.hasData && snapshot.data == true?
                      false: true
                  ),
                );
      }
    );
  }

  Widget _buildSlot(BuildContext context, Periods item) {
    return StreamBuilder<int>(
        stream: selectedBorder.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => selectedBorder.sink.add(item.id!),
            child: Container(
              height: 52.h,
              width: 140.w,
              alignment: Alignment.center,
              margin:
                  const EdgeInsetsDirectional.only(start: 12, end: 5, top: 30),
              decoration: BoxDecoration(
                  color:
                      selectedBorder.value != item.id ? whiteColor : primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: selectedBorder.value != item.id
                      ? Border.all(color: borderGrey)
                      : null,
                  boxShadow: const [
                    BoxShadow(
                        color: shadowColor,
                        offset: Offset(2, 2),
                      blurRadius: 9,
                      spreadRadius: -1,)
                  ]),
              child: Text(
                "${item.from} : ${item.to}",
                style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                    color:
                        selectedBorder.value != item.id ? blackColor : whiteColor,
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
