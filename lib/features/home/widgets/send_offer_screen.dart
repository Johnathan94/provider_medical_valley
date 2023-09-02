import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_initialized.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/extensions/string_extensions.dart';
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
    super.initState();
    branchesBloc.getBranches(widget.result.id!);
    selectedInsuranceStatus.sink.add(0);
  }

  @override
  void didChangeDependencies() {
    AppInitializer.initInsuranceOptions(context);
    super.didChangeDependencies();
  }

  int getDayId(int weedDay) {
    return weedDay == 6
        ? 1
        : weedDay == 7
            ? 2
            : weedDay + 2;
  }

  ScrollController scrollController = ScrollController();
  FocusNode node = FocusNode();
  late List branches;
  late List slots;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext, bool isKeyboardVisible) {
        sendButtonVisible.sink.add(!isKeyboardVisible);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: MyCustomAppBar(
              header: AppLocalizations.of(context)!.send_negotiation,
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
                          showOkBtn: false,
                          type: CoolAlertType.success,
                          text:
                              AppLocalizations.of(context)!.offer_sent_success,
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      } else if (state is ErrorNegotiationState) {
                        LoadingDialogs.hideLoadingDialog();
                        CoolAlert.show(
                          barrierDismissible: false,
                          context: context,
                          autoCloseDuration: const Duration(seconds: 1),
                          showOkBtn: false,
                          type: CoolAlertType.error,
                          title: AppLocalizations.of(context)!.error,
                          text: AppLocalizations.of(context)!
                              .something_went_wrong,
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
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          image: const DecorationImage(
                                            image: AssetImage(personImage),
                                          )),
                                    ), /*
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
                                    ),*/
                                  ],
                                ),
                                const SizedBox(
                                  width: 22,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .send_negotiation,
                                  style: AppStyles
                                      .baloo2FontWith400WeightAnd22Size
                                      .copyWith(
                                          color: blackColor,
                                          fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              AppLocalizations.of(context)!.choose_branch,
                              style: AppStyles.baloo2FontWith500WeightAnd16Size
                                  .copyWith(color: blackColor),
                            ),
                            BlocConsumer<BranchesBloc, BranchesState>(
                                listener: (context, state) {
                                  if (state is BranchesStateSuccess &&
                                      state.branches.isNotEmpty) {
                                    negotiationBloc.getSlot(
                                        state.branches.first.id!,
                                        widget.result.id!);

                                    selectedBranch.sink
                                        .add(state.branches.first.id!);
                                  }
                                },
                                bloc: branchesBloc,
                                builder: (context, state) {
                                  if (state is BranchesStateSuccess) {
                                    branches = state.branches;
                                    if (state.branches.isNotEmpty) {
                                      return SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            itemCount: state.branches.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder:
                                                (c, index) =>
                                                    StreamBuilder<int>(
                                                        stream: selectedBranch
                                                            .stream,
                                                        builder: (context,
                                                            snapshot) {
                                                          List<BranchesResponseModel>?
                                                              branches =
                                                              state.branches;
                                                          return GestureDetector(
                                                            onTap: () {
                                                              selectedBranch
                                                                  .sink
                                                                  .add(branches[
                                                                          index]
                                                                      .id!);
                                                              negotiationBloc
                                                                  .getSlot(
                                                                      branches[
                                                                              index]
                                                                          .id!,
                                                                      widget
                                                                          .result
                                                                          .id!);
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 3),
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              decoration: BoxDecoration(
                                                                  color: selectedBranch
                                                                              .value !=
                                                                          branches[index]
                                                                              .id!
                                                                      ? whiteColor
                                                                      : primaryColor,
                                                                  border: Border.all(
                                                                      color: selectedBranch.value !=
                                                                              branches[index].id!
                                                                          ? borderGrey
                                                                          : whiteColor)),
                                                              child: Text(
                                                                "${branches[index].location}",
                                                                style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                                                                    color: selectedBranch.value !=
                                                                            branches[index]
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
                                      return Text(AppLocalizations.of(context)!
                                          .no_branches);
                                    }
                                  } else if (state is BranchesStateError) {
                                    return Text(AppLocalizations.of(context)!
                                        .no_branches);
                                  } else if (state is BranchesStateLoading) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Container();
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.choose_time,
                              style: AppStyles.baloo2FontWith500WeightAnd16Size
                                  .copyWith(color: blackColor),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            BlocConsumer<NegotiationBloc, NegotiationState>(
                                listener: (context, state) {
                                  if (state is SuccessSlotState &&
                                      state.slotResponse.data!.isNotEmpty) {
                                    selectedBorder.sink
                                        .add(state.slotResponse.data!.first);
                                  }
                                },
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
                                          itemCount:
                                              state.slotResponse.data?.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (c, index) =>
                                              StreamBuilder<String>(
                                                  stream: selectedBorder.stream,
                                                  builder: (context, snapshot) {
                                                    List<String>? periods =
                                                        state
                                                            .slotResponse.data!;
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          selectedBorder.sink
                                                              .add(periods[
                                                                  index]),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 12,
                                                                vertical: 3),
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            color: selectedBorder
                                                                        .value !=
                                                                    periods[
                                                                        index]
                                                                ? whiteColor
                                                                : primaryColor,
                                                            border: Border.all(
                                                                color: selectedBorder
                                                                            .value !=
                                                                        periods[
                                                                            index]
                                                                    ? borderGrey
                                                                    : whiteColor)),
                                                        child: Text(
                                                          "${periods[index].hmFormat}",
                                                          style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                                                              color: selectedBorder
                                                                          .value !=
                                                                      periods[
                                                                          index]
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
                                focusNode: node,
                                controller: controller,
                                validator: (text) => text!.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .price_invalid
                                    : null,
                                decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.price,
                                    suffix: Text(
                                      "SR",
                                      style: AppStyles
                                          .baloo2FontWith400WeightAnd14Size,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: grey)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor))),
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
                  StreamBuilder<bool>(
                      stream: sendButtonVisible.stream,
                      builder: (context, snapshot) {
                        return Visibility(
                          visible: sendButtonVisible.value,
                          child: Positioned(
                            bottom: 30,
                            left: 25,
                            right: 25,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: PrimaryButton(
                                onPressed: () {
                                  ProviderData user = ProviderData.fromJson(
                                      LocalStorageManager.getUser()!);

                                  if (_formKey.currentState!.validate() &&
                                      selectedInsuranceStatus.hasValue &&
                                      selectedBorder.hasValue &&
                                      selectedBranch.hasValue) {
                                    negotiationBloc.sendOffer(SendOffer(
                                      price: double.parse(controller.text),
                                      requestId: widget.result.id,
                                      providerId: user.id,
                                      startTime: selectedBorder.value,
                                      branchId: selectedBranch.value,
                                      insuranceStatus:
                                          selectedInsuranceStatus.value,
                                    ));
                                  } else {
                                    context.showSnackBar(
                                        AppLocalizations.of(context)!
                                            .please_fill_all_data);
                                  }
                                },
                                text: AppLocalizations.of(context)!.send,
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildList() {
    return widget.result.userHasInsurance!
        ? List.generate(
            AppInitializer.insuranceOptions.length,
            (index) => StreamBuilder<int>(
                stream: selectedInsuranceStatus.stream,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () => selectedInsuranceStatus.sink.add(index),
                    child: Container(
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
                            onChanged: (int? newValue) =>
                                selectedInsuranceStatus.sink.add(index),
                          ),
                          Text(AppInitializer.insuranceOptions[index]
                              .toString()),
                        ],
                      ),
                    ),
                  );
                }))
        : [];
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  BehaviorSubject<bool> sendButtonVisible = BehaviorSubject.seeded(true);
  BehaviorSubject<String> selectedBorder = BehaviorSubject<String>();
  BehaviorSubject<int> selectedBranch = BehaviorSubject();
  BehaviorSubject<int> selectedInsuranceStatus = BehaviorSubject.seeded(0);
}
