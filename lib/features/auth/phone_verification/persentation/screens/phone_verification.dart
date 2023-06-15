import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/persentation/bloc/otp_bloc.dart';
import 'package:provider_medical_valley/features/home/widgets/home_base_stateful_widget.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/widgets/app_bar_with_null_background.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String mobile;
  const PhoneVerificationScreen(this.mobile, {Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  OtpBloc otpBloc = GetIt.instance<OtpBloc>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarWithoutBackground(
            header: AppLocalizations.of(context)!.phone_verification,
            leadingIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: whiteColor,
            child: Center(
              child: SizedBox(
                height: phoneVerificationBodyHeight.h,
                child: BlocListener<OtpBloc, OtpState>(
                  bloc: otpBloc,
                  listener: (context, state) async {
                    if (state is LoadingOtpState) {
                      await LoadingDialogs.showLoadingDialog(context);
                    } else if (state is SuccessOtpState) {
                      LoadingDialogs.hideLoadingDialog();
                      CoolAlert.show(
                        barrierDismissible: false,
                        context: context,
                        autoCloseDuration: const Duration(milliseconds: 300),
                        type: CoolAlertType.success,
                        text: AppLocalizations.of(context)!.success_login,
                      );
                      Future.delayed(const Duration(milliseconds: 350), () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>
                                    const HomeBaseStatefulWidget()));
                      });
                    } else {
                      LoadingDialogs.hideLoadingDialog();
                      CoolAlert.show(
                        context: context,
                        autoCloseDuration: const Duration(seconds: 1),
                        type: CoolAlertType.error,
                        text:
                            AppLocalizations.of(context)!.invalid_phone_number,
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPhoneVerificationDesc(),
                      buildOtpField(),
                      buildConfirmButton(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildPhoneVerificationDesc() {
    return Text(
      AppLocalizations.of(context)!.enter_you_otp,
      style: AppStyles.baloo2FontWith400WeightAnd25Size,
    );
  }

  buildOtpField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
        fieldWidth: otpFieldWidth.w,
        numberOfFields: otpFieldNumber,
        borderWidth: otpFieldBorderWidth.w,
        enabledBorderColor: greyWith80Percentage,
        focusedBorderColor: primaryColor,
        handleControllers: (List<TextEditingController?> controller) {
          controller[1]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[2]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[3]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[4]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[5]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
        },
        onSubmit: (String text) {
          code = text;
        },
        borderRadius:
            const BorderRadius.all(Radius.circular(otpFieldBorderRadius)),
        showFieldAsBox: true,
      ),
    );
  }

  String code = "";
  buildConfirmButton(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: loginButtonMarginHorizontal, end: loginButtonMarginHorizontal),
      child: TextButton(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  AppStyles.baloo2FontWith400WeightAnd22Size),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(loginButtonRadius),
              ))),
          onPressed: () {
            code.length == 6
                ? otpBloc.verifyOtp(code, widget.mobile)
                : context.showSnackBar(AppLocalizations.of(context)!.otp_error);
          },
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.continue_text,
              style: AppStyles.baloo2FontWith400WeightAnd22Size,
            ),
          )),
    );
  }
}
