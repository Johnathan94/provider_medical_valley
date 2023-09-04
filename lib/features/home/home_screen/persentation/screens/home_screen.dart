import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/notifications/notification_helper.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/widgets/request_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/app_styles.dart';
import '../../../../../core/strings/images.dart';
import '../../../widgets/home_base_app_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EarliestBloc earliestBloc = GetIt.I<EarliestBloc>();
  ScheduledBloc scheduledBloc = GetIt.I<ScheduledBloc>();
  final PagingController<int, BookRequest> immediatePagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, BookRequest> earliestPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, BookRequest> scheduledPagingController =
      PagingController(firstPageKey: 1);
  int immediateNextPage = 1;
  int earliestNextPage = 1;
  int scheduledNextPage = 1;
  int earliestNextPageKey = 1;
  int immediateNextPageKey = 1;
  int scheduledNextPageKey = 1;
  BehaviorSubject<int> immediateSubjectCounter = BehaviorSubject.seeded(0);
  BehaviorSubject<int> earliestSubjectCounter = BehaviorSubject.seeded(0);
  BehaviorSubject<int> scheduledSubjectCounter = BehaviorSubject.seeded(0);

  @override
  initState() {
    earliestBloc.getEarliestRequests(earliestNextPage, 10);
    scheduledBloc.getScheduledRequests(scheduledNextPage, 10);

    earliestPagingController.addPageRequestListener((pageKey) {
      earliestNextPageKey = 10 + earliestNextPage;
      earliestNextPage = pageKey + 1;
      earliestBloc.getEarliestRequests(earliestNextPage, 10);
    });
    scheduledPagingController.addPageRequestListener((pageKey) {
      scheduledNextPageKey = 10 + scheduledNextPage;
      scheduledNextPage = pageKey + 1;
      scheduledBloc.getScheduledRequests(scheduledNextPage, 10);
    });
    _handleRequestNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EarliestBloc, MyHomeState>(
            bloc: earliestBloc,
            listener: (c, MyHomeState state) {
              if (state is SuccessHomeState) {
                earliestSubjectCounter.sink.add(earliestSubjectCounter.value +
                    state.category.data!.results!.length);
                if (state.category.data!.results!.length == 10) {
                  earliestPagingController.appendPage(
                      state.category.data!.results!, earliestNextPage);
                } else {
                  earliestPagingController
                      .appendLastPage(state.category.data!.results!);
                }
              } else if (state is ErrorHomeState) {
                CoolAlert.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 1),
                  showOkBtn: false,
                  type: CoolAlertType.error,
                  title: AppLocalizations.of(context)!.error,
                  text: AppLocalizations.of(context)!.server_error,
                );
              }
            },
          ),
          BlocListener<ScheduledBloc, MyHomeState>(
            bloc: scheduledBloc,
            listener: (c, state) {
              if (state is SuccessHomeState) {
                scheduledSubjectCounter.sink.add(scheduledSubjectCounter.value +
                    state.category.data!.results!.length);

                if (state.category.data!.results!.length == 10) {
                  scheduledPagingController.appendPage(
                      state.category.data!.results!, scheduledNextPage);
                } else {
                  scheduledPagingController
                      .appendLastPage(state.category.data!.results!);
                }
              } else if (state is ErrorHomeState) {
                CoolAlert.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 1),
                  showOkBtn: false,
                  type: CoolAlertType.error,
                  title: AppLocalizations.of(context)!.error,
                  text: AppLocalizations.of(context)!.server_error,
                );
              }
            },
          ),
        ],
        child: getBody(),
      ),
    );
  }

  String getGreeting(context) {
    final DateTime now = DateTime.now();
    final int currentHour = now.hour;

    if (currentHour >= 0 && currentHour < 12) {
      return AppLocalizations.of(context)!.good_morning;
    } else {
      return AppLocalizations.of(context)!.good_evening;
    }
  }

  buildAppBar(context) {
    return CustomHomeAppBar(
      controller: TextEditingController(),
      goodMorningText: getGreeting(context),
      leadingIcon: SvgPicture.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      hiddenWidget: Container(),
    );
  }

  final RefreshController _earlistRefreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _scheduledRefreshController =
      RefreshController(initialRefresh: false);
  void _onRefreshReservations() async {
    _earlistRefreshController.requestRefresh();
    earliestPagingController.value.itemList?.clear();
    earliestNextPage = 1;
    earliestNextPageKey = 1;
    earliestSubjectCounter.sink.add(0);
    await earliestBloc.getEarliestRequests(earliestNextPage, 10);
    _earlistRefreshController.refreshCompleted();
  }

  void _onScheduledRefresh() async {
    scheduledPagingController.value.itemList?.clear();
    scheduledSubjectCounter.sink.add(0);
    scheduledNextPage = 1;
    scheduledNextPageKey = 1;
    await scheduledBloc.getScheduledRequests(scheduledNextPage, 10);
    _scheduledRefreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _earlistRefreshController.loadComplete();
  }

  void _scheduledOnLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _scheduledRefreshController.loadComplete();
  }

  Widget getBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: primaryColor,
          unselectedLabelColor: blackColor,
          indicatorColor: primaryColor,
          automaticIndicatorColorAdjustment: false,
          labelPadding: const EdgeInsets.all(12),
          labelStyle: AppStyles.baloo2FontWith500WeightAnd16Size,
          unselectedLabelStyle: AppStyles.baloo2FontWith400WeightAnd16Size
              .copyWith(color: blackColor),
          tabs: [
            StreamBuilder<int>(
                stream: earliestSubjectCounter.stream,
                builder: (context, snapshot) {
                  return Text(
                      "${AppLocalizations.of(context)!.earliest}(${earliestSubjectCounter.value})");
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(calendarIcon),
                SizedBox(
                  width: 5.w,
                ),
                StreamBuilder<int>(
                    stream: scheduledSubjectCounter.stream,
                    builder: (context, snapshot) {
                      return Text(" (${scheduledSubjectCounter.value})");
                    }),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            getEarliest(),
            getScheduled(),
          ],
        ),
      ),
    );
  }

  getEarliest() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Container(),
      ),
      controller: _earlistRefreshController,
      onRefresh: _onRefreshReservations,
      onLoading: _onLoading,
      child: PagedListView<int, BookRequest>(
        pagingController: earliestPagingController,
        padding: const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, BookRequest item, index) {
            return RequestCard(
              item,
            );
          },
        ),
      ),
    );
  }

  getScheduled() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Container(),
      ),
      controller: _scheduledRefreshController,
      onRefresh: _onScheduledRefresh,
      onLoading: _scheduledOnLoading,
      child: PagedListView<int, BookRequest>(
        pagingController: scheduledPagingController,
        padding: const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, BookRequest item, index) {
            return RequestCard(
              item,
              isCalendarRowShown: true,
              otherCard: true,
            );
          },
        ),
      ),
    );
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

  void _refreshHome(int notificationActionId) {
    if (notificationActionId == NotificationActions.AddBooking.index + 1) {
      _onRefreshReservations();
      _onScheduledRefresh();
    }
  }

  Future<void> _backgroundHandler(RemoteMessage event) async {
    final notificationActionId =
        NotificationHelper.getNotificationActionId(event);
    _refreshHome(notificationActionId);
  }
}
