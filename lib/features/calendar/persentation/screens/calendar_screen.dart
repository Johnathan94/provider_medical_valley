import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/extensions/string_extensions.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/bloc/negotiation_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/widgets/primary_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/dialogs/loading_dialog.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../offers/presentation/offers_screen.dart';
import '../../data/book_request_model.dart';
import '../bloc/book_request_bloc.dart';

class CalenderScreen extends StatefulWidget {
  final BookRequest request;
  const CalenderScreen({required this.request, Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  BehaviorSubject<String> selectedSlot = BehaviorSubject<String>.seeded("0");

  TextEditingController notesController = TextEditingController();
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();
  NegotiationBloc negotiationBloc = GetIt.instance<NegotiationBloc>();
  int getDayId(int weedDay) {
    return weedDay == 6
        ? 1
        : weedDay == 7
            ? 2
            : weedDay + 2;
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    negotiationBloc.getSlot(getDayId(now.weekday), widget.request.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          title: Text(AppLocalizations.of(context)!.schedule_an_appointment),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
        ),
        body: BlocListener<BookRequestBloc, BookRequestState>(
          bloc: bookRequestBloc,
          listener: (context, state) {
            if (state.state == BookedState.loading) {
              LoadingDialogs.showLoadingDialog(context);
            } else if (state.state == BookedState.success) {
              LoadingDialogs.hideLoadingDialog();
              CoolAlert.show(
                barrierDismissible: false,
                context: context,
                autoCloseDuration: const Duration(seconds: 1),
                showOkBtn: false,
                type: CoolAlertType.success,
                text: AppLocalizations.of(context)!.booked_successed,
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) => const OffersScreen()));
            } else {
              LoadingDialogs.hideLoadingDialog();
              CoolAlert.show(
                barrierDismissible: false,
                context: context,
                autoCloseDuration: const Duration(seconds: 1),
                showOkBtn: false,
                type: CoolAlertType.error,
                title: AppLocalizations.of(context)!.error,
                text: AppLocalizations.of(context)!.something_went_wrong,
              );
            }
          },
          child: _buildDefaultSingleDatePickerWithValue(),
        ));
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      lastMonthIcon: Container(),
      nextMonthIcon: Container(),
      selectedDayHighlightColor: primaryColor,
      weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 0,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.red,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 10),
          CalendarDatePicker2(
            config: config,
            initialValue: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (values) =>
                setState(() => _singleDatePickerValueWithDefaultValue = values),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20.w),
              Text(
                _getValueText(
                  config.calendarType,
                  _singleDatePickerValueWithDefaultValue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          BlocBuilder<NegotiationBloc, NegotiationState>(
              buildWhen: (prev, cur) =>
                  cur is SuccessSlotState ||
                  cur is ErrorSlotState ||
                  cur is LoadingSlotState,
              bloc: negotiationBloc,
              builder: (context, state) {
                if (state is SuccessSlotState) {
                  List<String>? periods = state.slotResponse.data!;
                  return Wrap(
                    children: periods
                        .map((String e) => StreamBuilder<String>(
                            stream: selectedSlot.stream,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: () => selectedSlot.sink.add(e),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectedSlot.value == e
                                          ? primaryColor
                                          : textFieldBg,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Text(
                                      "${e.hmFormat}",
                                      style: AppStyles
                                          .baloo2FontWith700WeightAnd15Size
                                          .copyWith(
                                              color: selectedSlot.value == e
                                                  ? textFieldBg
                                                  : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }))
                        .toList(),
                  );
                } else if (state is ErrorSlotState) {
                  return Text(AppLocalizations.of(context)!.there_is_no_slots);
                } else if (state is LoadingSlotState) {
                  return const CircularProgressIndicator();
                }
                return Container();
              }),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              minLines: 3,
              maxLines: 10,
              // user keyboard will have a button to move cursor to next line
              controller: notesController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.notes),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
            child: PrimaryButton(
              onPressed: () {
                ProviderData user =
                    ProviderData.fromJson(LocalStorageManager.getUser()!);
                bookRequestBloc.requestBook(BookRequestModel(
                    serviceId: widget.request.id!,
                    categoryId: widget.request.id!,
                    bookingTypeId: 3,
                    userId: user.id,
                    appointmentDate: _getValueText(
                      config.calendarType,
                      _singleDatePickerValueWithDefaultValue,
                    ),
                    appointmentTime: selectedSlot.value.toString(),
                    notes: notesController.text));
              },
              text: AppLocalizations.of(context)!.confirm,
            ),
          ),
        ],
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
