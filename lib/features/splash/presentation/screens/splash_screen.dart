import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:network_logger/network_logger.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_initialized.dart';
import 'package:provider_medical_valley/core/app_sizes.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/features/auth/login/presentation/screens/login_screen.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_bloc.dart';
import 'package:provider_medical_valley/features/home/home_screen/persentation/bloc/home_bloc.dart';
import 'package:provider_medical_valley/features/home/widgets/home_base_stateful_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    NetworkLoggerOverlay.attachTo(context);
    Future.delayed(const Duration(seconds: 1), () async {
      await AppInitializer.initializeAppWithContext(context);
      Map? userEncoded = LocalStorageManager.getUser();
      if (userEncoded == null) {
        goToLoginScreen(context);
      } else {
        ProviderData user =
            ProviderData.fromJson(LocalStorageManager.getUser()!);
        GetIt.instance<OffersBloc>()
            .getOffers(NegotiationsEvent(1, 10, user.id!));
        goToHomeScreen(context);
        GetIt.instance<HomeBloc>().updateFcmToken();
      }
    });
    super.initState();
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  goToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeBaseStatefulWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: primaryColor,
      child: Center(
          child: SvgPicture.asset(
        appIcon,
        width: splashIconWidth.w,
        height: splashIconHeight.h,
      )),
    );
  }
}
