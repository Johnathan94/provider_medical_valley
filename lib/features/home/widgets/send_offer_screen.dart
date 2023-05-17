import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_initialized.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:provider_medical_valley/features/branches/data/model/branches_response_model.dart';
import 'package:provider_medical_valley/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/bloc/negotiation_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/slots/slot_response_model.dart';
import 'package:provider_medical_valley/features/negotiate/presentation/screens/negotiate_screen.dart';
import 'package:rxdart/rxdart.dart';

class SendOfferScreen extends StatefulWidget {
  final BookRequest result;
  final bool immediateCard;
  final bool otherCard;
  const SendOfferScreen(
      {required this.result,
      required this.immediateCard,
      required this.otherCard,
      Key? key})
      : super(key: key);

  @override
  State<SendOfferScreen> createState() => _SendOfferScreenState();
}

class _SendOfferScreenState extends State<SendOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  NegotiationBloc negotiationBloc = GetIt.instance<NegotiationBloc>();
  BranchesBloc branchesBloc = GetIt.instance<BranchesBloc>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    DateTime now = DateTime.now();
    negotiationBloc.getSlot(
        getDayId(now.weekday), widget.result.providerServiceId!);
    super.initState();
    branchesBloc.getBranches();
    selectedInsuranceStatus.sink.add(0);
  }

  int getDayId(int weedDay) {
    return weedDay == 6
        ? 1
        : weedDay == 7
            ? 2
            : weedDay + 2;
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
      body: SizedBox(
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
                    autoCloseDuration: const Duration(seconds: 1),
                    type: CoolAlertType.success,
                    text: AppLocalizations.of(context)!.offer_sent_success,
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => NegotiateScreen(
                              result: widget.result,
                              immediateCard: widget.immediateCard,
                              otherCard: widget.otherCard,
                            )));
                  });
                } else if (state is ErrorNegotiationState) {
                  LoadingDialogs.hideLoadingDialog();
                  CoolAlert.show(
                    barrierDismissible: false,
                    context: context,
                    autoCloseDuration: const Duration(seconds: 1),
                    type: CoolAlertType.error,
                    text: AppLocalizations.of(context)!.something_went_wrong,
                  );
                }
              },
              child: Container(),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                "3 min",
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
                              Text(
                                widget.result.userStr ?? "",
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18Size
                                    .copyWith(
                                        color: blackColor,
                                        decoration: TextDecoration.none),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    cardIconOne,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    widget.result.categoryStr ?? "",
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
                                    widget.result.serviceStr ?? "",
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
                      SizedBox(
                        height: 24.h,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.send_negotiation,
                        style: AppStyles.baloo2FontWith500WeightAnd16Size
                            .copyWith(color: blackColor),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.choose_time,
                        style: AppStyles.baloo2FontWith500WeightAnd16Size
                            .copyWith(color: blackColor),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BlocBuilder<NegotiationBloc, NegotiationState>(
                          buildWhen: (prev, cur) =>
                              cur is SuccessSlotState ||
                              cur is ErrorSlotState ||
                              cur is LoadingSlotState,
                          bloc: negotiationBloc,
                          builder: (context, state) {
                            if (state is SuccessSlotState) {
                              return SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: state.slotResponse
                                        .serviceDaySlots?.first.periods?.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (c, index) => StreamBuilder<
                                            int>(
                                        stream: selectedBorder.stream,
                                        builder: (context, snapshot) {
                                          List<Periods>? periods = state
                                              .slotResponse
                                              .serviceDaySlots
                                              ?.first
                                              .periods;
                                          return GestureDetector(
                                            onTap: () => selectedBorder.sink
                                                .add(periods![index].id!),
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 3),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: selectedBorder.value !=
                                                          periods![index].id!
                                                      ? whiteColor
                                                      : primaryColor,
                                                  border: Border.all(
                                                      color: selectedBorder
                                                                  .value !=
                                                              periods[index].id!
                                                          ? borderGrey
                                                          : whiteColor)),
                                              child: Text(
                                                "${periods[index].from} : ${periods[index].to}",
                                                style: AppStyles
                                                    .baloo2FontWith400WeightAnd18Size
                                                    .copyWith(
                                                        color: selectedBorder
                                                                    .value !=
                                                                periods[index]
                                                                    .id!
                                                            ? blackColor
                                                            : whiteColor,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                              ),
                                            ),
                                          );
                                        })),
                              );
                            } else if (state is ErrorSlotState) {
                              return Text(AppLocalizations.of(context)!
                                  .there_is_no_slots);
                            } else if (state is LoadingSlotState) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.choose_branch,
                        style: AppStyles.baloo2FontWith500WeightAnd16Size
                            .copyWith(color: blackColor),
                      ),
                      BlocBuilder<BranchesBloc, BranchesState>(
                          bloc: branchesBloc,
                          builder: (context, state) {
                            if (state is BranchesStateSuccess) {
                              if (state.branches.isNotEmpty) {
                                selectedBranch.sink
                                    .add(state.branches.first.id!);
                                return SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount: state.branches.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (c, index) => StreamBuilder<
                                              int>(
                                          stream: selectedBranch.stream,
                                          builder: (context, snapshot) {
                                            List<BranchesResponseModel>?
                                                branches = state.branches;
                                            return GestureDetector(
                                              onTap: () => selectedBranch.sink
                                                  .add(branches[index].id!),
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: selectedBranch
                                                                .value !=
                                                            branches[index].id!
                                                        ? whiteColor
                                                        : primaryColor,
                                                    border: Border.all(
                                                        color: selectedBranch
                                                                    .value !=
                                                                branches[index]
                                                                    .id!
                                                            ? borderGrey
                                                            : whiteColor)),
                                                child: Text(
                                                  "${branches[index].location}",
                                                  style: AppStyles
                                                      .baloo2FontWith400WeightAnd18Size
                                                      .copyWith(
                                                          color: selectedBranch
                                                                      .value !=
                                                                  branches[
                                                                          index]
                                                                      .id!
                                                              ? blackColor
                                                              : whiteColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                ),
                                              ),
                                            );
                                          })),
                                );
                              } else {
                                return Text(
                                    AppLocalizations.of(context)!.no_branches);
                              }
                            } else if (state is BranchesStateError) {
                              return Text(
                                  AppLocalizations.of(context)!.no_branches);
                            } else if (state is BranchesStateLoading) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.enter_price,
                        style: AppStyles.baloo2FontWith400WeightAnd14Size
                            .copyWith(color: blackColor),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        width: 140,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller,
                          validator: (text) => text!.isEmpty
                              ? AppLocalizations.of(context)!.price_invalid
                              : null,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.price,
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
                      SizedBox(
                        height: 20.h,
                      ),
                      ...buildList(),
                      SizedBox(
                        height: 90.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 25,
              right: 25,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PrimaryButton(
                  onPressed: () {
                    ProviderData user =
                        ProviderData.fromJson(LocalStorageManager.getUser()!);

                    if (_formKey.currentState!.validate()) {
                      negotiationBloc.sendOffer(SendOffer(
                        price: int.parse(controller.text),
                        requestId: widget.result.id,
                        id: user.id,
                        userId: widget.result.userId,
                        periodId: selectedBorder.value,
                        branchId: selectedBranch.value,
                        insuranceStatus: selectedInsuranceStatus.value,
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
    );
  }

  List<Widget> buildList() {
    return widget.result.userHasInsurance!
        ? List.generate(
            AppInitializer.insuranceOptions.length,
            (index) => StreamBuilder<int>(
                stream: selectedInsuranceStatus.stream,
                builder: (context, snapshot) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: greyButton.withOpacity(.1),
                              offset: const Offset(2, 3),
                              blurRadius: 4,
                              spreadRadius: 3)
                        ]),
                    child: Row(
                      children: [
                        Radio<int>(
                            value: index,
                            activeColor: primaryColor,
                            groupValue: selectedInsuranceStatus.value,
                            onChanged: (int? newValue) {
                              selectedInsuranceStatus.sink.add(newValue!);
                            }),
                        Text(AppInitializer.insuranceOptions[index].toString()),
                      ],
                    ),
                  );
                }))
        : [];
  }

  BehaviorSubject<int> selectedBorder = BehaviorSubject.seeded(0);
  BehaviorSubject<int> selectedBranch = BehaviorSubject.seeded(0);
  BehaviorSubject<int> selectedInsuranceStatus = BehaviorSubject.seeded(0);
}
