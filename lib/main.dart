import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider_medical_valley/core/app_sizes.dart';
import 'package:provider_medical_valley/core/app_theme.dart';
import 'package:provider_medical_valley/core/base_service/flavors.dart';
import 'package:provider_medical_valley/core/medical_injection.dart';
import 'package:provider_medical_valley/core/notifications/notification_tab.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/urls.dart';
import 'package:provider_medical_valley/core/widgets/change_language_screen/peresentation/blocks/chnage_language_bloc.dart';
import 'package:provider_medical_valley/core/widgets/change_language_screen/peresentation/blocks/language_state.dart';
import 'package:provider_medical_valley/features/splash/presentation/screens/splash_screen.dart';
import 'package:rxdart/rxdart.dart';

import 'firebase_options.dart';

BehaviorSubject<int> negoNumber = BehaviorSubject.seeded(0);
String iconLinkPrefix = "https://alpha.api.medvalley-sa.com/";

LanguageBloc languageBloc = LanguageBloc();

class MyHttpOverrides extends HttpOverrides {
  BehaviorSubject<int> negoNumber = BehaviorSubject.seeded(0);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  NotificationTab.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.instance.getToken().then((value) => print(value));
  FirebaseMessaging.onMessage.listen((event) {
    if (kDebugMode) {
      print('hi message');
    }
    if (kDebugMode) {
      print(event.notification?.title);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.data);
    }
    _backgroundHandler(event);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    _backgroundHandler(event);

    if (kDebugMode) {
      print('hi message');
    }
    if (kDebugMode) {
      print(event.notification?.title);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.data);
    }
  });
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FlavorManager.setCurrentFlavor(Flavor(Strings.alphaBaseUrl, Strings.v_1));
  await LocalStorageManager.initialize();
  configureDependencies();
  String currentLanguage = LocalStorageManager.getCurrentLanguage();

  runApp(MyApp(currentLang: currentLanguage));
}

final GlobalKey<NavigatorState> navigatorGlobalKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String currentLang;
  MyApp({required this.currentLang, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        builder: (BuildContext context) {
          return BlocBuilder<LanguageBloc, LanguageState>(
              bloc: languageBloc,
              builder: (context, state) {
                print(state.locale?.languageCode);
                return ScreenUtilInit(
                    designSize: const Size(screenWidth, screenHeight),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return InAppNotification(
                        child: MaterialApp(
                          navigatorKey: navigatorGlobalKey,
                          theme: appTheme,
                          locale: state.locale ??
                              (currentLang.isNotEmpty
                                  ? Locale(currentLang)
                                  : const Locale("en")),
                          localizationsDelegates:
                              AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          onGenerateTitle: (context) =>
                              AppLocalizations.of(context)!.application_title,
                          debugShowCheckedModeBanner: false,
                          home: const SplashScreen(),
                        ),
                      );
                    });
              });
        },
        enabled: false);
  }
}
