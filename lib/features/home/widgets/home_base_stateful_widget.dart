import 'package:badges/badges.dart' as bad;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/screens/negotiations_screens.dart';
import 'package:provider_medical_valley/features/home/more_screen/presentation/more_screen.dart';
import 'package:provider_medical_valley/features/home/notifications/persentation/screens/notifications_screen.dart';
import 'package:provider_medical_valley/main.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/notifications/notification_helper.dart';
import '../home_screen/persentation/screens/home_screen.dart';

class HomeBaseStatefulWidget extends StatefulWidget {
  const HomeBaseStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBaseStatefulWidgetState();
}

class HomeBaseStatefulWidgetState extends State<HomeBaseStatefulWidget> {
  final BehaviorSubject<int> _index = BehaviorSubject();

  @override
  initState() {
    _handleRequestNotification();
    _index.sink.add(0);
    super.initState();
  }

  @override
  dispose() {
    _index.stream.drain();
    _index.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: getBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
      //   floatingActionButton: getFloatingButton(),
    );
  }

  getBody() {
    return StreamBuilder<int>(
      stream: _index,
      builder: (context, snapshot) {
        if (snapshot.data == 0) {
          return const HomeScreen();
        } else if (snapshot.data == 1) {
          return const NotificationsScreen();
        } else if (snapshot.data == 2) {
          return const NegotiationsScreen(categoryId: 11, serviceId: 1111);
        } else if (snapshot.data == 3) {
          return MoreScreen();
        }
        return Container(
          color: Colors.green,
        );
      },
    );
  }

  buildBottomNavigationBar() {
    return StreamBuilder<int>(
        stream: _index,
        builder: (context, snapshot) {
          return StreamBuilder<int>(
              stream: negoNumber.stream,
              builder: (context, state) {
                return BottomNavigationBar(
                  onTap: (newIndex) {
                    _index.sink.add(newIndex);
                  },
                  currentIndex: snapshot.data ?? 0,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle:
                      AppStyles.baloo2FontWith600WeightAnd18Size,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(homeIconDeactivated),
                        activeIcon: SvgPicture.asset(homeIconActive),
                        backgroundColor: whiteColor,
                        label: AppLocalizations.of(context)!.home),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(notificationIconDeactivated),
                        activeIcon: SvgPicture.asset(notificationIconActive),
                        backgroundColor: whiteColor,
                        label: AppLocalizations.of(context)!.notifications),
                    BottomNavigationBarItem(
                        icon: bad.Badge(
                            badgeContent: Text(negoNumber.value.toString()),
                            child:
                                SvgPicture.asset(negotiationIconDeactivated)),
                        activeIcon: bad.Badge(
                            badgeContent: Text(negoNumber.value.toString()),
                            child: SvgPicture.asset(negotiationIconActive)),
                        backgroundColor: whiteColor,
                        label: AppLocalizations.of(context)!.negotiation),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(menuIconDeactivated),
                        activeIcon: SvgPicture.asset(menuIconActive),
                        backgroundColor: whiteColor,
                        label: AppLocalizations.of(context)!.more),
                  ],
                );
              });
        });
  }

  void _handleRequestNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      _backgroundHandler(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _backgroundHandler(event);
    });
    // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _backgroundHandler(RemoteMessage event) async {
    final notificationActionId =
        NotificationHelper.getNotificationActionId(event);
    _navigate(notificationActionId);
  }

  void _navigate(int notificationActionId) {
    switch (notificationActionId - 1) {
      case 0:
        _index.sink.add(0);
        return;
      case 2:
        _index.sink.add(2);
        return;
      case 3:
        _index.sink.add(2);
    }
    if (notificationActionId == NotificationActions.AddBooking.index + 1) {
      _index.sink.add(0);
    }
  }
}
