import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/auth/login/presentation/bloc/loginState_state.dart';
import 'package:provider_medical_valley/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_paddings.dart';
import '../../../../../core/app_sizes.dart';
import '../../../phone_verification/persentation/screens/phone_verification.dart';
import '../../../widgets/authentication_app_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final BehaviorSubject<bool> _checkBoxBehaviourSubject =
      BehaviorSubject<bool>();
  final BehaviorSubject<bool> _behaviorSubject = BehaviorSubject<bool>();
  LoginBloc loginBloc = GetIt.instance<LoginBloc>();
  String countryDial = "966";
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    _checkBoxBehaviourSubject.sink.add(false);
    _behaviorSubject.sink.add(false);
    termsAcceptedBefore = LocalStorageManager.isTermsAcceptedBefore();

    super.initState();
  }

  bool? termsAcceptedBefore;

  @override
  dispose() {
    _checkBoxBehaviourSubject.stream.drain();
    _behaviorSubject.stream.drain();
    _checkBoxBehaviourSubject.close();
    _behaviorSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            color: primaryColor,
            child: Stack(
              children: [getLoginBackground(), getLoginBody(context)],
            ),
          ),
        ),
      ),
    );
  }

  getLoginBackground() {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      margin: const EdgeInsets.only(top: loginIconMarginTop),
      child: SvgPicture.asset(
        appIcon,
        width: loginIconWidth.w,
        height: loginIconHeight.h,
      ),
    );
  }

  getLoginBody(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
    return Positioned(
        top: loginBodyMarginTop.r,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: screenHeight,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(loginBodyRadius))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener<LoginBloc, LoginState>(
                    bloc: loginBloc,
                    listener: (context, state) async {
                      if (state is LoginStateLoading) {
                        await LoadingDialogs.showLoadingDialog(context);
                      } else if (state is LoginStateSuccess) {
                        LoadingDialogs.hideLoadingDialog();
                        navigateToOtpScreen();
                      } else {
                        LoadingDialogs.hideLoadingDialog();
                        CoolAlert.show(
                          context: context,
                          autoCloseDuration: const Duration(seconds: 1),
                          showOkBtn: false,
                          type: CoolAlertType.error,
                          text: AppLocalizations.of(context)!
                              .invalid_phone_number,
                          title: AppLocalizations.of(context)!.error,
                        );
                      }
                    },
                    child: Container()),
                buildLoginScreenTitle(),
                buildMobilePhoneField(),

                SizedBox(
                  height: 10.h,
                ),
                // termsAcceptedBefore == null || !termsAcceptedBefore!
                //     ? Padding(
                //         padding: const EdgeInsetsDirectional.only(
                //             start: loginRememberMeMarginStart),
                //         child: StreamBuilder<bool>(
                //             stream: _behaviorSubject.stream,
                //             builder: (context, snapshot) {
                //               return Row(
                //                 children: [
                //                   Theme(
                //                     data: theme.copyWith(
                //                         checkboxTheme: newCheckBoxTheme),
                //                     child: Checkbox(
                //                       value: _behaviorSubject.value,
                //                       activeColor: primaryColor,
                //                       materialTapTargetSize:
                //                           MaterialTapTargetSize.shrinkWrap,
                //                       onChanged: (newValue) {
                //                         _behaviorSubject.add(newValue ?? false);
                //                       },
                //                     ),
                //                   ),
                //                   Expanded(
                //                       child: GestureDetector(
                //                     onTap: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (c) =>
                //                                   const TermsAndConditionsScreen()));
                //                     },
                //                     child: Text(
                //                       AppLocalizations.of(context)!
                //                           .terms_and_condition_agreed,
                //                       style: AppStyles
                //                           .baloo2FontWith400WeightAnd18Size
                //                           .copyWith(
                //                               decoration: TextDecoration.none),
                //                     ),
                //                   ))
                //                 ],
                //               );
                //             }),
                //       )
                //     : const SizedBox(),
                SizedBox(
                  height: 16.h,
                ),
                buildRememberMe(),
                Container(
                  margin: mediumPaddingHV.r,
                  child: PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          (phoneController.text.length == 10 ||
                              phoneController.text.length == 9)) {
                        loginBloc.loginUser(
                            LoginEvent(countryDial + phoneController.text));
                      } else {
                        context.showSnackBar(
                            AppLocalizations.of(context)!.invalid_phone_number);
                      }
                    },
                    text: AppLocalizations.of(context)!.sign_in,
                  ),
                ),
                //   buildSignInApps(),
                //  buildSignUp()
              ],
            ),
          ),
        ));
  }

  buildLoginScreenTitle() {
    return Container(
      margin: EdgeInsets.only(top: loginTitleMarginTop.r),
      alignment: AlignmentDirectional.center,
      child: Text(
        AppLocalizations.of(context)!.login_title,
        style: AppStyles.baloo2FontWith400WeightAnd32Size,
      ),
    );
  }

  // String dialCode = "+966";
  buildMobilePhoneField() {
    return Container(
      margin: EdgeInsetsDirectional.only(
          top: loginMobileNumberFieldMarginTop.r,
          start: loginMobileNumberFieldMarginHorizontal.r,
          end: loginMobileNumberFieldMarginHorizontal.r),
      child: PhoneIntlWidgetField(phoneController, true, (Country country) {
        countryDial = country.dialCode;
      }),
    );
  }

  buildRememberMe() {
    return StreamBuilder<bool>(
        stream: _checkBoxBehaviourSubject.stream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsetsDirectional.only(
                start: loginRememberMeMarginStart),
            transform:
                Matrix4.translationValues(0.0, loginRememberMeMarginTop, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _checkBoxBehaviourSubject.value,
                  activeColor: primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (newValue) {
                    _checkBoxBehaviourSubject.sink.add(newValue ?? false);
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.remember_me_text,
                  style: AppStyles.baloo2FontWith400WeightAnd12Size,
                )
              ],
            ),
          );
        });
  }

  buildSignInApps() {
    return Container(
      margin: EdgeInsets.only(top: loginSignInAnotherAppsTextMarginTop.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.sign_in_with_apps,
              style: AppStyles.baloo2FontWith700WeightAnd15Size,
            ),
          ),
          Container(
            width: loginAllAnotherAppsWidth.w,
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: const [
                AuthenticationAppWidget(
                  appIcon: googleIcon,
                ),
                AuthenticationAppWidget(
                  appIcon: instagramIcon,
                  isSvg: false,
                ),
                AuthenticationAppWidget(
                  appIcon: twitterIcon,
                  isSvg: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  navigateToOtpScreen() {
    if (_behaviorSubject.value) LocalStorageManager.acceptTermsAndConditions();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PhoneVerificationScreen(countryDial + phoneController.text)));
  }
}
